require 'json'
require 'net/http'

Puppet::Functions.create_function(:'get_github_repos') do
  dispatch :get_github_repos do
    required_param 'String', :github_username
    optional_param 'String', :github_token
  end

  def get_github_repos(github_username, github_token = nil)
    uri = URI("https://api.github.com/users/#{github_username}/repos?per_page=1000")
    request = Net::HTTP::Get.new(uri)

    if github_token
      request['Authorization'] = "token #{github_token}"
    end

    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true
    response = http.request(request)

    repos = JSON.parse(response.body)

    repos.map do |item|
      {
        'name': item['name'],
        'ssh': item['ssh_url'],
        'http': item['clone_url'],
      }
    end
  end
end
