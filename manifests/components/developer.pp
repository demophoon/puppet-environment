define profiles::components::developer (
  String           $username        = $title,
  String           $project_dir     = 'projects',
  String           $home_dir        = "/home/${username}",
  String           $project_path    = "${home_dir}/${project_dir}",
  Optional[String] $github_token    = undef,
  Optional[String] $github_username,
) {
  Vcsrepo {
    refresh_only => true,
    owner        => $username,
    subscribe    => File[$project_path],
  }

  file { $project_path:
    ensure => directory,
    owner  => $username,
  }

  if $github_username {
    if $github_token != undef {
      $repos = get_github_repos($github_username, $github_token)
    } else {
      $repos = get_github_repos($github_username)
    }

    $repos.each |$repo| {
      $repo_name  = get_key_from_hash($repo, 'name')
      $ssh_clone  = get_key_from_hash($repo, 'ssh')
      $http_clone = get_key_from_hash($repo, 'http')

      vcsrepo { "${project_path}/${repo_name}":
        ensure   => present,
        provider => git,
        remote   => "${github_username}-http",
        source   => {
          $github_username => $ssh_clone,
          "${github_username}-http" => $http_clone
        },
      }
    }
  }
}
