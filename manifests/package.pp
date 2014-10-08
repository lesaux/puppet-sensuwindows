class sensuwindows::package (
$installdrive = 'c',
$installdir   = 'pythian',
$version      = '0.14.0-1',
) {

  

  file { "${installdrive}:/${installdir}":
    ensure => 'directory',
  }

  file { "${installdrive}:/${installdir}/sensu-${version}.msi":
    ensure => 'file',
    source => "puppet:///modules/sensuwindows/sensu-$version.msi",
    require => File["${installdrive}:/${installdir}"],
  }

  package {'Sensu':
    ensure   => present,
    source   => "${installdrive}:/${installdir}/sensu-$version.msi",
    provider => windows,
  }

  file { "${installdrive}:/${installdir}/sensu/conf.d":
    ensure => 'directory',
    require => Package['Sensu'],
  }

  file { "${installdrive}:/${installdir}/sensu/conf.d/client.json":
    ensure  => 'file',
    content => template('sensuwindows/client.json.erb'),
    require => File["${installdrive}:/${installdir}/sensu/conf.d"],
  }

  file { "${installdrive}:/${installdir}/sensu/conf.d/rabbitmq.json":
    ensure => 'file',
    content => template('sensuwindows/rabbitmq.json.erb'),
    require => File["${installdrive}:/${installdir}/sensu/conf.d"],
  }

}
