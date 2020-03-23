class profiles::roles::zoom () {
  package { 'zoom':
    ensure => 'purged',
  }

  file { '/usr/share/applications/zoomwc.desktop':
    ensure => present,
    mode   => '644',
    content => @(XDG/L),
      [Desktop Entry]
      Name=Zoom
      Comment=Zoom Video Conference Web Client Launcher
      Exec=/opt/zoomwc/bin/launch %U
      Icon=Zoom.png
      Terminal=false
      Type=Application
      Encoding=UTF-8
      Categories=Network;Application;
      StartupWMClass=Zoom
      MimeType=x-scheme-handler/zoommtg;x-scheme-handler/zoomus;x-scheme-handler/tel;x-scheme-handler/callto;x-scheme-handler/zoomphonecall;application/x-zoom;
      X-KDE-Protocols=zoommtg;zoomus;tel;callto;zoomphonecall;
      Name[en_US]=Zoom
      | XDG
  }

  file { ['/opt/zoomwc', '/opt/zoomwc/bin']:
    ensure => 'directory',
  }

  file { '/opt/zoomwc/bin/launch':
    ensure => present,
    mode   => '755',
    content => @(SH/L),
    #!/bin/sh

    URI="${*}"
    ID_PART="${URI#*confno=}"
    ID="${ID_PART%%&*}"
    ORG_PART="${URI#*://}"
    ORG="${ORG_PART%/*}"
    xdg-open "https://${ORG}/wc/join/${ID}"
    | SH
  }

  file { '/etc/xdg/mimeapps.list':
    ensure  => present,
    content => @(LIST/L),
    [Default Applications]
    | LIST
  }

  [
    'zoommtg',
    'zoomus',
    'tel',
    'callto',
    'zoomphonecall',
    'x-zoom',
  ].each |String $handler| {
    file_line { "Zoom desktop handler: ${handler}":
      path    => '/etc/xdg/mimeapps.list',
      line    => "x-scheme-handler/${handler}=zoomwc.desktop",
      require => File['/etc/xdg/mimeapps.list']
    }
  }
}
