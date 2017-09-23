Puppet::Functions.create_function(:'enable_private_hiera') do
  def enable_private_hiera()
    scope = closure_scope
    environment = scope['environment']
    [
      "/etc/puppetlabs/puppet/hiera/#{environment}",
      "/root/.ssh/id_rsa",
      "/root/.ssh/id_rsa.pub",
      "/root/.ssh/known_hosts",
    ].map do |item|
      File.exists?(filepath)
    end.all?
  end
end
