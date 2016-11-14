## Setting up a 'development' environment

See [DEV-README](DEV-README.md)...

## Infrastructure Organization

Outside of the development environment, hosts are named according to function, provider, and data center. For example:

```
util.       lde.        atl.          voceplatforms.com
^ function  ^ provider  ^ datacenter  ^ TLD
```

FUNCTIONS*:
* `nodeXXX`     = single full stack application server (NGINX, PHP-FPM, MySQL)
* `lbXXX`       = NGINX load balancer
* `appXXX`      = backend application server (PHP-FPM, node, Unicorn, etc.)
* `dbXXX`       = database server
* `stage`       = staging server (debug on, no output cache)
* `uat`         = uat server (debug off, output caching)
* `util`        = utility application server (Hubot, API, Packagist, etc.)
* `mtr`         = monitoring
* `log`         = log collection/analzying

PROVIDERS:
* `lde`         = Linode
* `rs`          = Rackspace

DATACENTERS:
* `atl`         = Atlanta, GA (Linode)
* `dal`         = Dallas, TX (Linode, Rackspace)
* `sjc`         = Fremont, CA (Linode)
* `ewr`         = Newark, NJ (Linode)
* `lon`         = London, UK (Linode)
* `tok`         = Tokyo, JP (Linode)
* `iad`         = North Virginia (Rackspace)
* `ord`         = Chicago (Rackspace)

* = there are some exceptions to the naming scheme, mostly how load balancers were named for various Disney projects. see `inventory/group_vars/rackspace.yml` for a breakdown.

## Content Organization

This largely follows a structure outlined in [Ansible Best Practices](http://docs.ansible.com/playbooks_best_practices.html). More information about Ansible, including documentation for various modules, can be found at [docs.ansibleworks.com](http://docs.ansible.com/).

    ├── README.md
    ├── ansible.cfg          # stores ansible config data
    ├── inventory
    │   ├── group_vars       # variables assigned to groups
    │   │   ├── all          # every host will get vars from 'all'
    │   │   ├── db           # specific vars for hosts in 'db' group
    │   │   └── web          # specific vars for hosts in 'web' group
    │   ├── host_vars
    │   │   └── my.host.com  # host specific vars
    │   ├── production       # hosts grouped by stage 'production'
    │   └── staging          # hosts grouped by stage 'staging'
    ├── library              # custom modules
    │   └── ghetto_facts     # retrieves application data from Ghetto
    ├── roles
    │   ├── common
    │   │   ├── defaults
    │   │   │   └── main.yml # default variables used within the role
    │   │   ├── files
    │   │   │   ├── bar.txt  # files for use with 'copy' module
    │   │   │   └── foo.sh   # scripts for use with 'script' module
    │   │   ├── handlers
    │   │   │   └── main.yml # executes actions from 'notifiers'
    │   │   ├── tasks
    │   │   │   └── main.yml # executes tasks, can include other files
    │   │   └── templates
    │   │       └── baz.j2   # jinja2 template for use with 'template' module
    └── site.yml             # master playbook

## What This Organization Enables (Specific Examples)

If you want to configure the entire production infrastructure:

    ansible-playbook -i inventory/live --limit 'production' live.yml

What about just reconfiguring backups on staging?

    ansible-playbook -i inventory/live --limit 'staging' --tags 'backups' live.yml

What about just NGINX hosts in production for specific hosts?

    ansible-playbook -i inventory/live --tags "nginx" --limit 'web*.rs.iad*' live.yml

How can I execute all tasks to setup a specific application in staging?

    ansible-playbook -i inventory/live --tags 'client:provision' --extra-vars='application=the_app' --limit 'staging' live.yml

Can I see what hosts and tasks would run against the "production" environment first?

    ansible-playbook -i inventory/live live.yml --list-tasks
    ansible-playbook -i inventory/live live.yml --list-hosts

Can I run ad-hoc commands against say, just the "production" MySQL hosts, or a specific host?

    ansible -i inventory/live database -m ping
    ansible -i inventory/live all -m ping -l util.rs.iad.voceplatforms.com

## inventory/host_vars/

`host_vars` should contain a YAML formatted file consisting of variables that apply to specific hosts - one file per host name. Variables applied to a host take precedence over those provided via `group_vars`.

## inventory/group_vars/

`group_vars` should contain YAML formatted files consisting of variables that apply to hosts in specific groups.

## Variable Precedence

See: [Variable Precedence: Where Should I Put A Variable?](http://docs.ansible.com/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable)

## git-crypt

Some `host_vars` or `group_vars` files are encrypted to protect the sensitive information contained within them using `git-crypt`. You will need the secret key the files were encrypted with in order to decrypt them.

Which files should be encrypted are set via the project's `.gitattributes` file.

To get setup using `git-crypt`, on a Mac with Homebrew:

```
$ brew install git-crypt
```

For other platforms, see the `INSTALL` documentation at [AGWA/git-crypt](https://github.com/AGWA/git-crypt).

## YAML Validation

Since YAML vars files will sometimes constain sensitive information, you can use the following Ruby snippet to lint your YAML files.

```ruby
require 'yaml'
require 'ya2yaml'

yaml = YAML.load(open('group_vars/all'))
out = yaml.ya2yaml(:syck_compatible => true)
```

## Testing the `ghetto_facts` module

Assuming a cloned copy of Ansible itself exists in `$HOME/src`, execute:

```
$HOME/src/ansible/hacking/test-module \
  -m ./library/ghetto_facts \
  -a 'key=API_KEY host=HOST.COM stage=STAGE application=NAME'
```
The arguments, supplied with `-a`, should be changed accordingly to match tests:

* `key` = your Ghetto API key
* `host` = the server FQDN
* `stage` = the environment for the host (staging, production, etc.)
* `application` = a specific application name or 'all'
