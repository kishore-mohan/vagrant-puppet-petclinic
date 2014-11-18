# == Class: petclinic
#
# Puppet module to install Spring Petclinic on Tomcat 8
#
# == Parameters:
#
# $petclinic_war_url:: URL of the petclinic war file (can be http://, https:// or puppet:///)
#
# === Examples
#
#  class { 'petclinic':
#  }
#
# === Authors
#
# Cyrille Le Clerc <cleclerc@cloudbees.com>
#
# === Copyright
#
# Copyright 2014 CloudBees Inc.
#
class petclinic ($petclinic_war_url = "https://github.com/cyrille-leclerc/spring-petclinic/releases/download/petclinic-1.0.0-clc/petclinic.war"){

  info "This deployment uses $petclinic_war_url"

  # JAVA
  class { 'java': } ->

  class { 'epel': }->

  # TOMCAT
  class { 'tomcat': }
  tomcat::instance{ 'default':
    package_name        => 'tomcat',
    source_url => 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz'
  } ->
  tomcat::war { 'petclinic.war': 
    war_source => $petclinic_war_url
  } ->
  tomcat::service { 'default': }
  
  
  # FIREWALL
  include firewall

  firewall { '100 allow http and https access':
    port   => [8080],
    proto  => tcp,
    action => accept,
  }
}
