Exec { path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin" ] }

class system-update {
    
    exec { 'apt-get update':
        command => ['apt-get update']
    }

    $sysPackage = ["build-essential"]
    package { $sysPackage:
        ensure => "installed",
        require => Exec['apt-get update'],
    }
}

class development {
    $devPackages = ["curl", "git-core"]
    package { $devPackages:
        ensure => 'latest',
        require => Exec['apt-get update']
    }
}

class dev_php {

    php::module { ["curl"]:
        notify => Service['apache'],
        source => "/vagrant/conf/curl.ini"
    }

    php::module { ["gd"]:
        notify => Service['apache'],
        source => "/vagrant/conf/gd.ini"
    }

    php::module { ["mysql"]:
        notify => Service['apache'],
        source => "/vagrant/conf/mysql.ini"
    }

    php::module { ["mcrypt"]:
        notify => Service['apache'],
        source => "/vagrant/conf/mcrypt.ini"
    }

    php::module { ["intl"]:
        notify => Service['apache'],
        source => "/vagrant/conf/intl.ini"
    }

    php::module { ['apc']:
        notify => Service['apache'],
        source => "/vagrant/conf/apc.ini",
        package_prefix => "php-"
    }

    php::module { ["xdebug"]:
        notify => Service['apache'],
        source => "/vagrant/conf/xdebug.ini"
    }

    php::conf { ["mysqli"]:
        require => Package["php5-mysql"],
        notify => Service["apache"],
        source => "/vagrant/conf/mysqli.ini"
    }

    php::conf { ["pdo"]:
        require => Package["php5-mysql"],
        notify => Service["apache"],
        source => "/vagrant/conf/pdo.ini"
    }

    php::conf { ["pdo_mysql"]:
        require => Package["php5-mysql"],
        notify => Service["apache"],
        source => "/vagrant/conf/pdo_mysql.ini"
    }

    file { "/etc/php5/conf.d/custom.ini":
            owner => root,
            group => root,
            mode => 664,
            source => "/vagrant/conf/custom.ini",
            notify => Service['apache'],
        }

}

class { 'apt':
  always_apt_update => true
}

class { "mysql":
  root_password => 'root',
}

Exec["apt-get update"] -> Package <| |>

include system-update

include php::apache2
include dev_php

include apache
include mysql

include development
