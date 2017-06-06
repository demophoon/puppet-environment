Puppet for my environment
=========================

Automatic way
-------------------------

curl -L https://raw.githubusercontent.com/demophoon/puppet-environment/production/install.sh | bash

Manual way
-------------------------

How to setup:

* Install Puppet
* Install r10k
* Configure r10k with the configuration file below into `/etc/puppetlabs/r10k/r10k.yaml`
```yaml
:cachedir: '/var/cache/r10k'
:sources:
    :default:
        remote: 'https://github.com/demophoon/puppet-environment.git'
        basedir: '/etc/puppet/environments'
        # Or if you are running Puppet 4.x with r10k 2.x
        # basedir: '/etc/puppetlabs/code/environments'
```
* Run r10k: `r10k deploy environment -pv`
* Run Puppet: `puppet apply --modulepath /etc/puppet/environments/production/modules/ /etc/puppet/environments/production/site.pp`

Enjoy your new puppet environment!
