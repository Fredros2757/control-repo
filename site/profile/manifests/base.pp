#
# profile::base base klassen for felles konfigurasjoner
#

class profile::base {

  # the base profile should include component modules that will be on all nodes

  # installing python and pip
  class { 'python' :
    version    => 'system',
    pip        => 'latest',
  }

  # pip docker package
  python::pip { 'docker':
    ensure    => 'latest',
    require   => Class['python'],
  }

  # docker latest
  class { 'docker':
    version => 'latest',
    before  => File['/etc/systemd/system/docker.service.d/kolla.conf'],
  }

  # ntp
  class { 'ntp':
  
  }
  
  # Setting the timezone
  class { 'timezone':
    timezone => 'Europe/Oslo',
  }

  # tee /etc/systemd/system/docker.service.d/kolla.conf >> [Service] MountFlags=shared
  file { '/etc/systemd/system/docker.service.d/kolla.conf':
    ensure => file,
    path => '/etc/systemd/system/docker.service.d/kolla.conf',
    replace => 'no',
    content => "[Service]\n MountFlags=shared",
  }
  
  package {'mariadb-client-core-10.1':
     ensure    => present,
  }
}
