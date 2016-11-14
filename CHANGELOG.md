'ansible' Changes By Release
==========================

**TRUNK**
Features:
* Support for Pantheon push-deploys
* Allow wpSubdomain to be set as null instead of requiring it to be undefined.
* Renewed *.voceconnect.com certificate
* Pinning mariadb package

Fixes:
* fix SAVEQUERIES
* removed the tcp:// prefix for the session.save_path since it isnt compatible when using memcached
* removed mongodb from backups on servers not using mongo
* changed uat and staging to use localhost as memcached servers


**1.8.1.0 - December 16, 2014**

Deprecated:
* 'nginx-lb' role (replaced by 'nginx' role)
* 'nginx-web' role (replaced by 'nginx' role)

Features:
* Vagrant: 1.7.1, VirtualBox: 4.3.20, Ansible: 1.8.1
* New provider: Rackspace
* New datacenter: IAD
* Primary supported OS: Debian 7 (Wheezy)
* MySQL replication
* GlusterFS support
* fail2ban now uses escalating 'repeat offender' jails
* Ghetto fact gathering now supports overwriting any data received from the API in the development environment (useful for testing without having to update API instance data)
* Collapse NGINX into a single role with different types of configurations that can be conditionally included or broken down by a server type (backend, standalone, lb)
* Add support for '429 Request Limit Reached' errors
* Upgrade to NGINX 1.7.7 with latest openssl
* Add NGINX maps for 301 redirects, forcing SSL for URIs
* Generate HyperDB db-config.php for web hosts
* Bind address for Redis (for binding to something other than localhost)
* Multiple memcached server session handling

Fixes:
* Matching log paths in MySQL configurations based on rsyslog configurations
* Ghetto fact gathering misc. fixes/updates
* Cleanup/update default 'sandbox.json' based on API values
* Disable wp-config.php AUTOMATIC\_UPDATER\_DISABLED and DISALLOW\_FILE\_MODS in staging and development (allows viewing of which plugins are out of date)
* NGINX cache inspector script to output correct dates
* NGINX cache paths
* Deny requests for PHP files in WordPress media directories, wp-config.php
* Send mail for user 'robot' to 'root' 
* Allow lo, eth0, eth1 to hit WordPress cron endpoints

**1.7.2.0 - October 14, 2014**

Features:
* New host: node002.lde.nj.voceplatforms.com
* Webgrind instance on development environments
* New instance variables: nginxRequestLimits, wpCommentsCheck, phpEnvVariables
* Production NGINX log retention set to 180 days
* Switch to use Ansible 'ufw' module
* Update NGINX to latest custom built packages (1.6.2)
* Update application supervisor jobs to allow grouping
* Update 'bin/dev setup' to ensure support Ansible version is used

Fixes:
* Removal of weaker/unsupported RC4 SSL ciphers
* Ensure /etc/resolv.conf in development environments is immutable
* Change PHP session.save_path to new default
* Change MTA for backups to use sendmail
* Update ansible.cfg
* Silence WordPress wp-cron output in staging/uat
* Disable AcceptEnv in sshd configurations
* Remove WP_CONTENT_URL from wp-config.php
* Check and SSL domains from instance data for dnsmasq
* Install PHPUnit from phar package instead of pear

**1.6.8.1 - July 29, 2014**

Features:
* Upgrade to PHP 5.5

Fixes:
* Cleanup PHP by removing un-needed tasks due to changes in PHP 5.5 and related packages

**1.6.8.0 - July 27, 2014**

Features:
* Allow all to push deploy to UAT
* Allow all to SSH to UAT
* Add task to export and migrate database+assets from UAT to staging

Fixes:
* Fix Vagrant download link in DEV-README.md
* Allow SSH password authentication in dev
* Add tags to push-deploy tasks for 'client:provision'
* Check item.instance.ssl count in wp-config.php
* Remove MySQL strict modes
* Add system level cron to execute requests to WordPress wp-cron.php
* Reapply fix to disable open_file_cache in development
* Update install process for WP-CLI
* Only ship to Loggly for production servers
* PlayStation dev domain in Vagrantfile
* Ensure symlinks for projects are created during 'client:provision' tag
* Add 'mysql2' gem for all hosts (needed for wp-cron)
* Allow backends to set X-Frame-Options without being stripped via proxy_/fastcgi_hide_header
* MySQL production configuration InnoDB buffer size
* Ensure live hosts for group 'supervisor-jobs'

**1.6.1.0 - July 15, 2014**

Features:
* Update to 'Ansible Galaxy'-ready roles complete with default variables and documentation.
* Split inventories into 'development' and 'live'. 'live' servers can be controlled by using the `-l` flag if needed.
* Switch to using a host installed copy of Ansible core (instead of relying on the virtual machine to contain it)
* Tag cleanup and consolidating - client applications can be re-provisioned with a single tag: `client:provision`
* Split MySQL configurations by total memory size of target instead of storing configurations in inventory files.
* Split NGINX into two roles - one for load balancing/caching/shedding requests and one for backend requests that fastcgi/proxy pass.
* Update PHP role to specifically set modules that should be enabled or disabled
* Update fail2ban to use latest version (supports persistence across restarts without custom filters and actions)
* Support for a "sandbox" WordPress instance at "sandbox.voceconnect.dev"
* Sunset "sensu" role
* Add "nuke" script for development environments to erase virtual machine and start from scratch
* Management of `/etc/hosts` file
* Setup Sphinx SQL instances by pulling configurations from a specified S3 bucket and having a single 'sphinx' SQL user that has read only access to all tables (breaks reliance on application specific credentials being required and stored in a configuration that is stored publicly).
* rsyslog support for discarding specific unwanted messages
* PHP session support switched to use memcached (instead of flat files)
* Add support with 'pt-kill' supervisorctl job to kill long running SQL queries in production
* Add commented out configuration logic in FPM pool configuration to quickly enable XDebug trace output
* Support for loading variables that need to be conditionally defined based on the OS of the host - e.g. variables specific to Debian vs. Ubuntu
* Add support for application level jobs to be defined to execute through supervisorctl (e.g. 'disneynewsroom' use of PHP Resque+Redis)
* Arrange data for wp-comments-post.php referrer blocking, include support for only allowing POST size less than 3kb in length

Fixes:
* Rename inventories to include '.yml' extension
* CORS headers for font serving in NGINX
* Remove deprecated SCEA Sphinx SQL configuraitons
* Remove 'apticron'
* Remove 'peon' (not required to install on live hosts)
* Increase timeouts in development (NGINX, PHP execution)
* Allow SSH SOCKS proxying
* fail2ban repeat-offender filter only matched previous version log output
* Log the request length in NGINX (client "Content-Length" header)

**1.5.4.2 - May 14, 2014**

Features:
* Remove quoted 'when' conditions (unless quotes needed)
* robots.txt for CDN enabled sites recommends no crawl
* Add 'request_is_from_netdna_cdn' var to access logs
* Cleanup/rename NGINX configs
* Allow any user to deploy production 'builds'
* Add 'redis' to all hosts
* Add application level 'supervisor' configs to be used for, but not limited to, applications using php-resque

Fixes:
* Rename 'rabbitmq-env.config' to 'rabbitmq.config'
* Set 'user_install=no' on 'gem' module to avoid installing to user's $HOME
* Allow Facebook IP ranges through htpasswd on staging/UAT
* Return '403' instead of '444' when CDN attempts to serve non-static assets
* Unquote 'when' conditionals
* Remove 'update_cache=yes' on 'apt' module when preceded by 'apt_repository' (which handles apt update automatically when repository is added/changed)
* PHP 5.4.28 socket permissions
* Update directory for default NGINX config removal
* Remove duplicate NGINX limit connection/request zones
* Flush handlers on monitor hosts after installing RabbitMQ

**1.5.4.1 - April 29, 2014**

Deprecated:
* 'webrootRelativePath' support

Features:
* Add support for NetDNA secrets in deploy user $HOME/.capfile
* Add 'sensu' monitoring role, basic checks for all hosts
* Update NGINX to 1.6.0
* Update NGINX tasks to use variable for current version
* Update NGINX templates to use variable for static assets, update mime.types

Fixes:
* Update some vars to be better grouped with where they're used, more generic
* Ensure exit status from pre-receive hook deploy command is used
* Remove 'radius' app cron job
* Reduce production php5-fpm process usage
* Update origin/hostname in Postfix
* Remove Vagrant::BatchAction fix from Vagrantfile
* Remove references to hosts that were never added, thanks Disney!
* Checking for 'pip' command caused playbook execution to fail if not installed
* Vagrant provisioner runs with verbose output turned on
* Clear root mail (erases 'unable to resolve host' messages that occurred before /etc/hosts and /etc/hostname set)
* Update SSL certificate and key for blog.sonyentertainmentnetwork.com
* Update SSL certificate and key for *.voceconnect.com

**1.5.4.0 - April 7, 2014**

Features:
* Update to match latest Ansible release (1.5.4)
* Refactor /opt/tools fix permission scripts

Fixes:
* Add libmemcachedutil2 package to satisfy dependency on php5-memcached

**1.5.0.2 - April 4, 2014**

Features:
* Push deploy updates to use new capistrano-platforms gem (v1.0.0)
* pre-receive hook for push deploy refactored to Ruby, SSHKit for consistency with cap deploy output
* post-receive hook just calls 'exit 0'
* Use custom build Ruby package (2.0.0-p353)
* Add /root/.gemrc file

Deprecated:
* Fuel PHP application type
* Expression Engine application type
* 'vipprod', 'vippreprod', 'codedrop' push deploy stages

**1.5.0.1 - March 18, 2014**

Features:
* Update to match latest Ansible release (1.5.0)
* Add support for using the PHP memcached library

**1.4.5.1 - March 11, 2014**

Features:
* Host renames to include datacenter and provider
* MySQL 5.6 upgrade
* ZSH (Z-Shell) support
* Message of the day support
* Split database role into masters and slaves, as well as separate role for Percona (to make way for MariaDB+Galera cluster)
* Create 'common' group vars to hold variables common to all servers that doesn't use the reserved 'all' group
* Update NGINX and add new variable 'nginxLoggedInCookies' to indicate whether a user has a cookie that would have them logged in. Variable is logged, and used by fail2ban to ignore banning users that could be possibly logged in.
* Update fail2ban with a 'repeat offenders' jail - 5 bans+unbans will result in a permanent block
* Refactor PHP-FPM configurations to use less conditional logic
* Add support for project instances to set their own 'maxUploadSize'

Fixes:
* Only add gitolite configurations for project with active instances
* Only use fail2ban for NGINX repeated POST attempts, WordPress logins in production environments
* Miscellaneous updates for host variables and "changed" output

**1.4.4.2 - February 12, 2014**

Features:
* Add 'bin/dev' scripts for provisioning and updating development environments

Fixes:
* Sunset 'Jarvis'
* Allow 'git push' with '--force' to non-production end-points (#188)
* Push deploy functionality cleans up branches that no longer exist at GitHub (#186)

**1.4.4.1 - January 27, 2014**

_version numbers will now start with `X.Y.Z` where `X.Y.Z` matches the current version of Ansible, followed by a point version that relates to this specific project_

Features:
* Support for Vagrant 1.4.3
* Documentation updates
* Mount a single project folder in development environments then symlink into current. Prevents needing to 'vagrant reload' everytime a new project is added.
* Add provision bash script that will run Ansible commands to provision the full stack (if it hasn't been run in a week or more) or just update application configs and dependencies.

Fixes:
* Move apticron related tasks to live with cron job tasks

**1.4.4 - January 6, 2014**

Features:
* Updates to work with Ansible 1.4.4 released on January 6th, 2014 (ansible/ansible)
* Ansible command wrapper script (for executing frequently run commands, creating an entry point for API integration)
* WP-CLI
* Update to NGINX 1.4.4
* Adds fail2ban configurations for use with WordPress 'wp-fail2ban' plugin
* Slack integration
* Updates to directory structures, application configs, and removing of VIP plugin cloning - all handled by Composer

Fixes:
* When run with --extra-vars for 'application', dnsmasq templates would only provide entries for the specific applications instead of all applications it could host
* nginxCachePath usage and permissions
* Include html/htm as a static type in NGINX for WordPress applications

**1.3.7 - November 14, 2013**

Features:
* Use of 'changed_when' to better report when tasks have actually changed something
* Removal of the 'test' stage - the approach should be to mirror any given machine exactly in a local environment as it would be in a production level environment
* Add support for 'nginxInPHPLocation' variable

Fixes:
* Remove deprecated '$' variables in tasks
* Remove tags where they're not needed/already provided via role defaults
* Ensure /etc/resolv.conf lists 'nameserver 127.0.0.1' in development environments
* NGINX try_files for WordPress shouldn't contain 'q=$uri' (props @jeffstieler)

**1.3.6 - November 7, 2013**

Deprecated:
* Sentry (sentry.voceconnect.com)

Features:
* Add 'packagist' applications, cron jobs to 'packagist' role
* Switch to 'htpasswd' module
* New 'executeFixPermissions' var to indicate if permission fixing scripts should run, defaults to false

Fixes:
* 'application/json' MIME type for NGINX

**1.3.5 - October 24, 2013**

Features:
* More filters for fail2ban based on log events
* Persistence for blocked IPs across fail2ban restarts
* NGINX upgrade to 1.4.3 (custom built with needed 3rd party modules) for both Debian and Ubuntu
* NGINX SPDY support, updated SSL ciphers
* Local *.staging.voceconnect.dev SSL certificate, signed with Voce Platforms root CA
* Remove 'logDestinations', add necessary config for all environments except development/test
* Commit Vagrantfile and use a YAML '.virtualbox-settings' file to store per user configurations

Fixes:
* Remove 'firewallBlacklist' - let 'fail2ban' manage instead
* fail2ban portscan blocking false positives on 80/443
* New Relic duplicate configuration file being added (#176)
* pecl/pear install failing if package already installed (#177)
* Fix for validating username and password for MySQL data in development environments

**1.3.4 - October 16, 2013**

Features:
* Support for Debian Wheezy for the 'common' role
* Replace Unbound DNS server with Dnsmasq (Unbound tasks to be removed in future release)
* Replace Shorewall firewall with UFW (Shorewall tasks to be removed in future release)
* Integrate fail2ban for blocking repeated malicious requests against apps, SSH brute forces, etc.

Fixes:
* Update aptitude cache before installing PHP packages
* Switch an instances `nodeEnvVariables` to an array of objects (@brockangelo)
* Troubleshooting doc update for when XCode isn't installed (@matstars)
* Fix request execution timeout in PHP-FPM for dev environments
* Updates to DEV-README

**1.3.3 - October 9, 2013**

Features:
* Keeps up with Ansible 1.3.3 released on October 9th, 2013 (ansible/ansible)
* Use `ssh-agent` forwarding in case the VM needs to clone anything from GitHub. Would rely on host machine having the proper identities added with `ssh-add` (props @jeffstieler)
* Update git repo paths to instead use https, unless it's a private repository. This keeps from having a required SSH key and a GitHub account just to clone a public repo, and reduces the setup step of needing to provide a `robotSSHGitHubRSA` for dev environments
* Begin new 'security' set of tasks under 'common' role for anything related to hardening/auditing of machines
* Add support for mapping a path using `assetsMapping` (use case: disneyparks)
* Add `apticron` instead for reporting on packages needing update

Fixes:
* Disable NGINX `open_file_cache` in development environments resolving an issue where a changed file wouldn't appear on the VM or would cause a 404 error when the asset was indeed present (props @markparolisi)
* Remove `peon` from needing to be installed on the VM
