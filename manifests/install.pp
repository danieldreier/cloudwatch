# == Class cloudwatch::install
#
# This class is called from cloudwatch for install.
#
class cloudwatch::install {
  wget::fetch { 'cloudwatch agent installer':
      source      => 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py',
      destination => "/usr/local/src/awslogs-agent-setup.py",
      timeout     => 0,
      unless      => "test $(ls -A /etc/init.d/awslogs 2>/dev/null)",
      notify      => Exec['install cloudwatch log agent'],
  }

  exec { 'install cloudwatch log agent':
    path        => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
    command     => "python /usr/local/src/awslogs-agent-setup.py --non-interactive --region=${::cloudwatch::region} --configfile=/var/tmp/awslogs.conf",
    onlyif      => '[ -e /usr/local/src/awslogs-agent-setup.py ]',
    refreshonly => true,
    unless      => '[ -f /etc/init.d/awslogs ]',
    require     => File['/var/tmp/awslogs.conf'],
    before      => [ Service['awslogs'], File[$cloudwatch::config_file] ],
  }
}
