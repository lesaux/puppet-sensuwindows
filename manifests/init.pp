class sensuwindows (
  $version                  = '0.14.0-1',
  $installdrive             = 'c',
  $installdir               = 'pythian',
  $rabbitmq_port            = '5671',
  $rabbitmq_server          = '192.168.0.84',
  $rabbitmq_username        = 'sensu',
  $rabbitmq_password        = 'sensu123',
  $rabbitmq_vhost           = '/sensu',
  $subscriptions            = "['windows']"
) {

class {'sensuwindows::package': }
class {'sensuwindows::service': }

}
