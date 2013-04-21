include hadoop

group { "puppet":
  ensure => "present"
}

exec { 'apt-get update':
  command => 'apt-get update',
  path    => '/usr/bin'
}

package { "openjdk-6-jdk":
   ensure => present,
   require => Exec['apt-get update']
}

file { "/root/.ssh":
  ensure => "directory",
  require => Exec['apt-get update']
}

file { "/root/.ssh/id_rsa":
  source => "puppet:///modules/hadoop/id_rsa",
  mode => 600,
  owner => root,
  group => root,
  require => File["/root/.ssh"]
}

file { "/root/.ssh/id_rsa.pub":
  source => "puppet:///modules/hadoop/id_rsa.pub",
  mode => 644,
  owner => root,
  group => root,
  require => File["/root/.ssh"]
}

ssh_authorized_key {"ssh_key":
  ensure => "present",
  key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDFewB2BlmahcXBmQFQFFl0yFHq+w157D2fvXYsCyx+eI5PKTGqToGudYBKlh4F6qhQYELRnh+lxrxVaL/LFq0CfaecBfdiec7SfqdFMYTe22wTTxz0ligZLryrcjgO2FpaH0OYMyZPgmDCwycr5I24y1IOUN78PRl9BRgI22rvZ+doH4BHcNBNHQPDui2aWxB7p4ur6qt9lo6OL3dbYiU6SRgo/9/QGJ4B2oEHP2x4rMcXXzHWKF8ZsHRwnHOjpjbzzs7P5oOZplTmFVtDf5yQ/wM7h/rPlo6BRmiHofRyzsBNexdtUOa861jjgDJjjpqK4a7ssutWCBPXgEAo1Frv",
  type => "ssh-rsa",
  user => "root",
  require => File["/root/.ssh/id_rsa.pub"]
}

