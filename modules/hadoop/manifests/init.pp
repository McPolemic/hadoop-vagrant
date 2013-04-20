class hadoop {
    $hadoop_home = "/opt/hadoop"

    exec { "download_hadoop":
      command => "/usr/bin/wget -O /tmp/hadoop.tar.gz http://apache.mirrors.timporter.net/hadoop/common/hadoop-1.0.4/hadoop-1.0.4.tar.gz",
                 path => $hadoop_home,
                 unless => "/bin/ls /opt | /bin/grep hadoop-1.0.4",
                 require => Package["openjdk-6-jdk"]
    }

    exec { "unpack_hadoop" :
      command => "tar zvxf /tmp/hadoop.tar.gz -C /opt",
      path => "/bin",
      creates => "${hadoop_home}-1.0.4",
      require => Exec["download_hadoop"]
    }
}
