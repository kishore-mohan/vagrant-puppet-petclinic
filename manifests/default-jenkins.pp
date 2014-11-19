# define jenkins ip for puppet report in Vagrant
host { 'jenkins.localdomain':
    ip => '172.28.128.1',
} ->
class { 'petclinic': 
  petclinic_war_url => "puppet:///modules/petclinic/petclinic.war"
} 



