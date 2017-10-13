Puppet::Functions.create_function(:'get_key_from_hash') do
  dispatch :get_key_from_hash do
    required_param 'Hash', :_hash
    required_param 'String', :_key
  end

  def get_key_from_hash(_hash, _key)
    _hash[_key.to_sym]
  end
end
