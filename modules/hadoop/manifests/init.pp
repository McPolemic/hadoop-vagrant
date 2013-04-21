class hadoop {
  $hadoop_home = "/opt/hadoop-1.0.4"

  exec { "download_hadoop":
    command => "wget -O /tmp/hadoop.tar.gz http://apache.mirrors.timporter.net/hadoop/common/hadoop-1.0.4/hadoop-1.0.4.tar.gz",
    path => '/usr/bin',
    unless => "/bin/ls /opt | /bin/grep hadoop-1.0.4",
    require => Package["openjdk-6-jdk"]
  }

  exec { "unpack_hadoop" :
    command => "tar zvxf /tmp/hadoop.tar.gz -C /opt",
    path => "/bin",
    creates => "${hadoop_home}",
    require => Exec["download_hadoop"]
  }
  file {"${hadoop_home}/conf/slaves":
      source => "puppet:///modules/hadoop/slaves",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }
  file {"${hadoop_home}/conf/masters":
      source => "puppet:///modules/hadoop/masters",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }
  file {"$hadoop_home/conf/core-site.xml":
      source => "puppet:///modules/hadoop/core-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }
  file {"$hadoop_home/conf/mapred-site.xml":
      source => "puppet:///modules/hadoop/mapred-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }
  file {"$hadoop_home/conf/hdfs-site.xml":
      source => "puppet:///modules/hadoop/hdfs-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }
  file { "${hadoop_home}/conf/hadoop-env.sh":
     source => "puppet:///modules/hadoop/hadoop-env.sh",
     mode => 644,
     owner => root,
     group => root,
     require => Exec["unpack_hadoop"]
  }
}
