Puppet for my environment
=========================

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
```
* Run r10k: `r10k deploy environment -pv`
* Run Puppet: `puppet apply --modulepath /etc/puppet/environments/production/modules/ /etc/puppet/environments/production/site.pp`

Enjoy your new puppet environment!
