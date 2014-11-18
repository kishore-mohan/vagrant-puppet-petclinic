
class { 'petclinic': 
  petclinic_war_url => "puppet:///modules/petclinic/petclinic.war"
} 

host { 'jenkins.localdomain':
    ip => '172.28.128.1',
}

