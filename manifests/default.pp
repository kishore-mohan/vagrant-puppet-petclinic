# define jenkins ip for puppet report in Vagrant
host { 'jenkins.localdomain':
    ip => '172.28.128.1',
} ->
class { 'petclinic': 
  petclinic_war_url => "https://github.com/cyrille-leclerc/spring-petclinic/releases/download/petclinic-1.0.0-clc/petclinic.war"
} 


