Puppet::Functions.create_function(:'profiles::file_exists') do
  dispatch :file_exists do
    param 'String', :filepath
  end

  def file_exists(filepath)
    File.file?(filepath)
  end
end
