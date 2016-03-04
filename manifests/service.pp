# == Class cloudwatch::service
#
# This class is meant to be called from cloudwatch.
# It ensure the service is running.
#
class cloudwatch::service {
  service { 'awslogs':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [ Exec['install cloudwatch log agent'], File[$cloudwatch::config_file] ],
  }
}
