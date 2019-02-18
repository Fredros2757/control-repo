#
# Puppet manager role class

class role::manager {

  include profile::base
  include {'profile::manager':
 
  }

}
