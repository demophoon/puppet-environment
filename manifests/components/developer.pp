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
      vcsrepo { "${project_path}/${repo[name]}":
        ensure   => present,
        provider => git,
        remote   => "$github_username-http",
        source   => {
          $github_username        => $repo[ssh],
          "$github_username-http" => $repo[http]
        },
      }
    }
  }
}
