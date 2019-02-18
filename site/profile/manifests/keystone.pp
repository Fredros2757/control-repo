class profile::keystone {

  # this manifests is only for manager node
  file { 'en fil':
    path => '/root/mortyboiii',
    owner => 'root',
    ensure => 'directory',
  } 

}
