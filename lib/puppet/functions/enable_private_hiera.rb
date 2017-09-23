Puppet::Functions.create_function(:'profiles::enable_private_hiera') do
  dispatch :enable_private_hiera do
  end

  def enable_private_hiera()
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
