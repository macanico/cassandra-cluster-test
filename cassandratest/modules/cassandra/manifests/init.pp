# Class: cassandra
#
# This module manages cassandra
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cassandra {


#define the base repo

  apt::source { 'cassandra':
  location   => 'http://debian.datastax.com/community',
  repos      => 'main',
  key        => 'http://debian.datastax.com/debian/repo_key',
  key_server => 'pgp.mit.edu',
  }


#install the needed packages
    package { 'python-cql':
        ensure => installed,
    }
    
    package { 'dsc20=2.0.11-1':
        ensure => installed,
    } 
    
    package { 'cassandra=2.0.11':
        ensure => installed,
        audit  => all,
        notify => Exec['delete_default_data_files'],
    }
    
    exec{'delete_default_data_files':
    refreshonly  => true,
    command      => "service cassandra stop && rm -rf /var/lib/cassandra/data/system/",
    }
    
#remove the default data files    




}
