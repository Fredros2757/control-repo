class role::database_server {

  #All roles should include the base profile
  include profile::base
  include profile::keystone

}
