# == Class cloudwatch::params
#
# This class is meant to be called from cloudwatch.
# It sets variables according to platform.
#
class cloudwatch::params {
  # determine the availability zone
  # requires a fairly recent version of facter (any puppet 4 agent is sufficient)
  if $::facts['ec2_metadata']['placement']['availability-zone'] =~ /^([a-z]+-[a-z]+-\d+)(\S)$/ {
    $region = $1
  }
  assert_type(String[1], $region)

  $conf_path   = '/var/awslogs/etc/config/'
  $config_file = '/var/awslogs/etc/awslogs.conf'
}
