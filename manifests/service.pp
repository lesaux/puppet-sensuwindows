class sensuwindows::service (

$installdrive   = 'c',
$installdir     = 'pythian',
$sc_cmd         = 'c:\\Windows\System32\\sc.exe',
$powerhsell_cmd = 'c:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe',
) {

file { "${installdrive}:/${installdir}/sensu/bin/sensu-client.xml":
  ensure  => 'file',
  content => template('sensuwindows/sensu-client.xml.erb'),
  require => Package['Sensu'],
}


$service_config = "start= auto binPath= ${installdrive}:\\${installdir}\\bin\\sensu-client.exe DisplayName= \"Sensu Client\""
$service_exists = "${powerhsell_cmd} get-service -name sensu-client"

#Exec { path => $::path }

exec { 'create_sensu_service':
    command => "${sc_cmd} create sensu-client $service_config",
    unless => $service_exists,
    require => File["${installdrive}:/${installdir}/sensu/bin/sensu-client.xml"],
}
#->
#exec { 'update_service':
#    command => "sc config $service_name $service_config",
#    onlyif => $service_exists,
#}
->
exec { 'configure_sensu_service_recovery':
    command => "c:\\Windows\System32\\sc.exe failure sensu-client reset= 120 actions= restart/10000/restart/10000/restart/10000",
}
#->
#exec { 'disable_recovery':
#    command => "sc failureflag $service_name 0",
#}
#->
#exec { 'stop_service':
#    command => "powershell stop-process -name $process_name",
#    returns => [0, 1],
#}
#->
#file { 'copy_package':
#    ensure => directory,
#    force => true,
#    mode => '0600',
#    path => $package_target,
#    purge => true,
#    recurse => true,
#    source => $package_source,
#}
#->
#exec { 'inherit_permissions':
#    command => "icacls $package_target /reset /T",
#}
#->
#exec { 'configure_service':
#    command => "cmd /C $package_target/config.cmd",
#}
#->
#exec { 'enable_recovery':
#    command => "sc failureflag $service_name 1",
#}
#->
#exec { 'start_service':
#    command => "sc start $service_name",
#}

}
