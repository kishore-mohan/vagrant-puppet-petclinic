class { 'haproxy': }
haproxy::listen { 'web':
    ipaddress        => '*',
    ports            => '80',
    options   => {
      'mode'  => 'http',
      'stats' => [
        'uri /stats',
      ],  
    },
}

haproxy::balancermember { 'haproxy':
  listening_service => 'web',
  ports             => '8080',
  ipaddresses       => '127.0.0.1',
  options           => 'check',
}

include haproxy