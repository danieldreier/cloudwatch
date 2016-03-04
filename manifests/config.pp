# == Class cloudwatch::config
#
# This class is called from cloudwatch for service config.
#
# This class creates the main config file. Each individual log file being
# watched will create an additional config file in /var/awslogs/etc/config/
#
class cloudwatch::config {
  $config_content = @(EOF)
    [general]
    # This system is managed by Puppet.
    # Changes will be overwritten on next Puppet Agent run.
    state_file = /var/awslogs/state/agent-state
    |- EOF

  file { ['/var/awslogs/etc', '/var/awslogs']:
    ensure => directory,
    owner   => 'root',
    group   => 'root',
  }

  file { $cloudwatch::conf_path:
    ensure  => directory,
    purge   => true,
    recurse => true
  }

  file { $cloudwatch::config_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => inline_epp($config_content),
    require => File['/var/awslogs/etc'],
    notify  => Service['awslogs'],
  }

  # the cloudwatch agent installer expects to copy the given config file
  # to a new location, so we have to create a second copy to let it
  file { '/var/tmp/awslogs.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => inline_epp($config_content),
  }
}
