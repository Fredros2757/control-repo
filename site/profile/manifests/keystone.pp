class role::keystone {

  #All roles should include the base profile
  include profile::base
  include profile::keystone

}
