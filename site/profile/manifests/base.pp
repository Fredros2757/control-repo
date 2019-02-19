#
# profile::base base klassen for felles konfigurasjoner
#

class profile::base {

  # the base profile should include component modules that will be on all nodes

  # update før alt annet
  exec { 'apt-get update':
    user     => root,
  }

  # python-pip
  package { 'python-pip':
    ensure   => installed,
    provider => apt,
    user     => root,
  }

  # pip
  package { 'pip':
    ensure   => latest,
    provider => pip,
    require  => Package['python-pip'],
    user     => root,
  }
 
  # pip docker package
  package {'docker':
    ensure => latest,
    provider => 'pip',
  }
 
  # docker latest
  class { 'docker':
    version => 'latest',
    before  => File['/etc/systemd/system/docker.service.d'],
  }

  # ntp
  class { 'ntp':
  
  }  
  
  class { 'timezone':
    timezone => 'Europe/Oslo',
  }

  # mkdir -p /etc/systemd/system/docker.service.d
  file { '/etc/systemd/system/docker.service.d':
    ensure => directory,
    path   => '/etc/systemd/system/docker.service.d',
    replace => 'no',
  }

  # tee /etc/systemd/system/docker.service.d/kolla.conf >> [Service] MountFlags=shared
  file { '/etc/systemd/system/docker.service.d/kolla.conf':
    ensure => file,
    path => '/etc/systemd/system/docker.service.d/kolla.conf',
    replace => 'no',
    content => "[Service]\n MountFlags=shared",
    require => File['/etc/systemd/system/docker.service.d'],  
  }

  # TODO: systemctl daemon-reload systemctl restart docker
}
