class profile::keystone {
  $ssh_pub = lookup('ssh_pub')

  #exec { 'cat <<EOF > /root/.ssh/authorized_keys $ssh_pub EOF': }
  file {'/home/ubuntu/.ssh/authorized_keys':
     ensure    => 'present',
     content   => $ssh_pub,
  }
}
