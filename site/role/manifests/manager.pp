#
# Puppet manager role class

class role::manager {
  include profile::base
  class { 'profile::manager':
  }
}
