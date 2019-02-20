#
# The manager profile class
#
class profile::manager {
  
  $ansible_config = lookup('ansible_config')
  $globals_config = lookup('globals_config')
  $multinode_config = lookup('multinode_config')

  # Installing ansible on manager node
  # class { 'ansible':
  #   ensure           => 'present',
  #   version          => '2.4.0',
  #   private_key_file => '/etc/keys',
  # }   
   
     
   package {'ansible':
     ensure   => 'latest',
   }
   
   python::pip { 'ansible':
     ensure   => '2.4',
   }
   
   python::pip { 'kolla-ansible':
     ensure   => 'latest',
     before   => File['kolla', 'inventory', '/root/kolla-ansible/etc/kolla'],
   }
   
   # copying some folders
  file {'kolla':
    ensure   => 'directory',
    source   => '/usr/local/share/kolla-ansible/etc_examples/kolla',
    recurse  => 'remote',
    path     => '/etc/',
  }
  
  file {'inventory':
    ensure   => 'directory',
    source   => '/usr/local/share/kolla-ansible/ansible/inventory/',
    recurse  => 'true',
    path     => '/root/'
   }

  file {'/etc/ansible/ansible.cfg':
    ensure   => 'present',
    content  => $ansible_config,
    require  => Package['ansible'],  
  }

  vcsrepo { '/root/kolla':
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/openstack/kolla.git',
  }

  vcsrepo { '/root/kolla-ansible':
    ensure   => 'present',
    provider => 'git',
    source   => 'https://github.com/openstack/kolla-ansible.git',
  } 
  

  file {'/root/kolla-ansible/etc/kolla':
     ensure   => 'directory',
     source   => '/root/kolla-ansible/etc/kolla/',
     recurse  => 'true',
     path     => '/etc/kolla/',
     before   => File['/etc/kolla/globals.yml'],
  }

  # globals_config
  file {'/etc/kolla/globals.yml':
    ensure   => 'present',
    content  => $globals_config,
  }
 
  # multinode_config
  file {'/root/multinode.ini':
    ensure   => 'present',
    content  => $multinode_config,
  }

  # apt-get install -y python-dev libffi-dev gcc libssl-dev python-selinux python-setuptools
  package {['libffi-dev', 'gcc', 'libssl-dev', 'python-selinux', 'python-setuptools']:    
    ensure    =>  'present',
    provider  =>  'apt',
  }
}
