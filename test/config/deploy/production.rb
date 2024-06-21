server "localhost", user: "willnet", roles: %w{app db web}, port: 8022

set :ssh_options, {
  user: 'willnet',
  password: 'password',
  forward_agent: false,
  auth_methods: %w(password)
}
