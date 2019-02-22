#
# Puppet manager role class

class role::manager {
  include profile::base_config
  class { 'profile::manager':
  }
}
