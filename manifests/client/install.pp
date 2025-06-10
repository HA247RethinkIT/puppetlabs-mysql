# @summary
#   Private class for MySQL client install.
#
# @api private
#
class mysql::client::install {

  if $mysql::client::package_manage {
    if $mysql::server::package_name == 'percona-server-client' {
      class { 'apt': }

      if ! defined(Apt::Source['percona-80']) {
        apt::source { 'percona-80':
          location => 'http://repo.percona.com/ps-80/apt/',
          repos    => 'main',
          key      => {
            id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
            source => 'https://www.percona.com/downloads/RPM-GPG-KEY-percona',
          },
          include => { src => false },
        }
      }

      if ! defined(Apt::Source['percona_tools']) {
        apt::source { 'percona_tools':
          location => 'http://repo.percona.com/tools/apt/',
          repos    => 'main',
          key      => {
            id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
            source => 'https://www.percona.com/downloads/RPM-GPG-KEY-percona',
          },
          include => { src => false },
        }
      }

      if ! defined(Exec['apt_update_percona']) {
        exec { 'apt_update_percona':
          command     => '/usr/bin/apt-get update',
          refreshonly => true,
          path        => ['/usr/bin', '/usr/sbin', '/bin'],
        }
      }

      # Only chain the ones that actually exist:
      if defined(Apt::Source['percona-80']) {
        Apt::Source['percona-80'] -> Exec['apt_update_percona']
      }
      if defined(Apt::Source['percona_tools']) {
        Apt::Source['percona_tools'] -> Exec['apt_update_percona']
      }
    }
    elsif $mysql::server::package_name == 'percona-server-client-5.7' {
      class { 'apt': }

      if ! defined(Apt::Source['percona-5-7']) {
        apt::source { 'percona-5-7':
          location => 'http://repo.percona.com/ps-57/apt/',
          repos    => 'main',
          key      => {
            id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
            source => 'https://www.percona.com/downloads/RPM-GPG-KEY-percona',
          },
          include => { src => false },
        }
      }

      if ! defined(Apt::Source['percona_tools']) {
        apt::source { 'percona_tools':
          location => 'http://repo.percona.com/tools/apt/',
          repos    => 'main',
          key      => {
            id     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
            source => 'https://www.percona.com/downloads/RPM-GPG-KEY-percona',
          },
          include => { src => false },
        }
      }

      if ! defined(Exec['apt_update_percona']) {
        exec { 'apt_update_percona':
          command     => '/usr/bin/apt-get update',
          refreshonly => true,
          path        => ['/usr/bin', '/usr/sbin', '/bin'],
        }
      }

      # Only chain the ones that actually exist:
      if defined(Apt::Source['percona-5-7']) {
        Apt::Source['percona-5-7'] -> Exec['apt_update_percona']
      }
      if defined(Apt::Source['percona_tools']) {
        Apt::Source['percona_tools'] -> Exec['apt_update_percona']
      }
    }

    package { 'mysql_client':
      ensure          => $mysql::client::package_ensure,
      install_options => $mysql::client::install_options,
      name            => $mysql::client::package_name,
    }

  }

}
