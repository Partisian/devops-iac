class modulea {
file { '/home/ubuntu':
        ensure => directory,
        owner => 'ubuntu',
        group => 'ubuntu',
}

package { 'htop':
    ensure => installed,
}

exec { "apt-update":
  command => "/usr/bin/apt-get update"
}

exec { "install-dep":
  command => "/usr/bin/apt-get --yes install apt-transport-https ca-certificates curl software-properties-common"
}

exec { "curl-docker":
  command => "/usr/bin/curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
}

exec { "add-docker-dep":
  command => "/usr/bin/add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'"
}

Exec["apt-update"] -> Package <| |>
Exec["install-dep"] -> Package <| |>
Exec["curl-docker"] -> Package <| |>
Exec["add-docker-dep"] -> Package <| |>
Exec["apt-update"] -> Package <| |>

package { 'docker-ce':
    ensure => installed,
}


file { "/home/ubuntu/test.txt":
        mode => "0644",
        owner => 'ubuntu',
        group => 'ubuntu',
        source => "puppet:///modules/modulea/test.txt",
    }
}
