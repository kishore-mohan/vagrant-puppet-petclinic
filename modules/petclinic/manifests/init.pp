# == Class: petclinic
#
# Puppet module to install Spring Petclinic on Tomcat 8
#
# == Parameters:
#
# [*petclinic_war_url*]
#   URL of the petclinic war file (can be http://, https:// or puppet:///).
#
# === Examples
#
#  class { 'petclinic':
#       petclinic_war_url => "https://example.com/.../petclinic.war"
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

  info "This petclinic deployment uses $petclinic_war_url"

  # FIREWALL
  firewall { '100 allow http 8080 access':
    port   => [8080],
    proto  => tcp,
    action => accept,
  } ->

  # JAVA
  class { 'java': } ->

  # TOMCAT
  class { 'tomcat': }
  tomcat::instance{ 'default':
    package_name        => 'tomcat',
    source_url => 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz'
  } ->
  exec { "workaround_force_replace_war":
    # workaround manually delete the war because puppetlabs-tomcat:v1.2.0 does not overwrite existing war if the source is "puppet:///..."
    command => "rm /opt/apache-tomcat/webapps/petclinic.war  || :",
    path    => "/usr/local/bin/:/usr/bin:/bin/"
  } ->
  tomcat::war { 'petclinic.war': 
    war_source => $petclinic_war_url
  } ->
  # manually track file as puppetlabs-tomcat does not track war file checksum
  # see https://github.com/jenkinsci/puppet-jenkinstracking/
  track { '/opt/apache-tomcat/webapps/petclinic.war':
  } ->
  tomcat::service { 'default': }
}
