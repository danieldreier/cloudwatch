# Class: cloudwatch
# ===========================
#
# Full description of class cloudwatch here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class cloudwatch ()
  inherits ::cloudwatch::params {
  include ::cloudwatch::config
  include ::cloudwatch::install
  include ::cloudwatch::service
}
