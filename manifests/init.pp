# Class: java78
#
# This module manages Oracle Java7 & 8
# Parameters: none
# Requires:
#  apt
# Sample Usage:
#  include java78
class java78 (
    $versions = [ '7', '8' ],
    $default = '7',
  ){

  validate_array($versions)

  $default_ver = $default ? {
      undef    => $versions[0],
      $default => $default
  }

  case $::operatingsystem {
    debian: {
      include apt

      apt::source { 'webupd8team-java':
        location    => 'http://ppa.launchpad.net/webupd8team/java/ubuntu',
        release     => 'precise',
        repos       => 'main',
        key         => '7B2C3B0889BF5709A105D03AC2518248EEA14886',
        key_server  => 'keyserver.ubuntu.com',
        include_src => true
      }

      if '7' in $versions {
        package { 'oracle-java7-installer':
          responsefile => '/tmp/java7.preseed',
          require      => [
                            Apt::Source['webupd8team'],
                            File['/tmp/java7.preseed']
                          ],
        }
      }

      if '8' in $versions {
        package { 'oracle-java8-installer':
          responsefile => '/tmp/java8.preseed',
          require      => [
                            Apt::Source['webupd8team'],
                            File['/tmp/java8.preseed']
                          ],
        }
      }
    }

    ubuntu: {
      include apt

      apt::ppa { 'ppa:webupd8team/java': }

      if '7' in $versions {
        package { 'oracle-java7-installer':
          responsefile => '/tmp/java7.preseed',
          require      => [
                            Apt::Ppa['ppa:webupd8team/java'],
                            File['/tmp/java7.preseed']
                          ],
        }
      }

      if '8' in $versions {
        package { 'oracle-java8-installer':
          responsefile => '/tmp/java8.preseed',
          require      => [
                            Apt::Ppa['ppa:webupd8team/java'],
                            File['/tmp/java8.preseed']
                          ],
        }
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }

  case $::operatingsystem {
    debian, ubuntu: {
      if '7' in $versions {
        file { '/tmp/java7.preseed':
          source => 'puppet:///modules/java78/java7.preseed',
          mode   => '0600',
          backup => false,
        }
      }

      if '8' in $versions {
        file { '/tmp/java8.preseed':
          source => 'puppet:///modules/java78/java8.preseed',
          mode   => '0600',
          backup => false,
        }
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }

  if $default_ver == '7' {
    file { '/etc/profile.d/set_java_home.sh':
      ensure  => file,
      group   => root,
      owner   => root,
      mode    => '0755',
      content => "export JAVA_HOME=/usr/lib/jvm/java-${default_ver}-oracle/\nexport PATH=\${JAVA_HOME}/bin:\${PATH}",
      require => Package['oracle-java7-installer']
    }
  }

  if $default_ver == '8' {
    file { '/etc/profile.d/set_java_home.sh':
      ensure  => file,
      group   => root,
      owner   => root,
      mode    => '0755',
      content => "export JAVA_HOME=/usr/lib/jvm/java-${default_ver}-oracle/\nexport PATH=\${JAVA_HOME}/bin:\${PATH}",
      require => Package['oracle-java8-installer']
    }    
  }
}
