# Developer Environments

## Supported Versions

* **Vagrant**: 1.7.1
* **VirtualBox**: 4.3.20
* **Ansible**: 1.8.1

## Getting Started
### Setup/Verify SSH Configuration
Before starting the installation, you should setup and verify your SSH settings for our servers.

1. Generate or use an existing SSH key and send the public key to someone with access to add it to our systems.
2. Add the following to your `~/.ssh/config` file:
    ```
    ############################################################################
    # VOCE
    ############################################################################
    Host development.voceplatforms.com
        HostName 192.168.33.10
        User vagrant
        IdentityFile /Users/<your user>/.ssh/vagrant

    Host *.voceplatforms.com
        Port 22
        PasswordAuthentication no
    
    Host staging.voceplatforms.com
        HostName 104.130.162.232
        IdentityFile /Users/<your user>/.ssh/<the key file you generated>
        User <the system username you were given>
    
    Host uat.voceplatforms.com
        HostName 104.130.164.59
        IdentityFile /Users/<your user>/.ssh/<the key file you generated>
        User <the system username you were given>
    
    Host git.voceplatforms.com
        HostName 104.130.27.73
        IdentityFile /Users/<your user>/.ssh/<the key file you generated>
        User <the system username you were given>
    ```
3. Verify that you are able to ssh into each of `staging.voceplatforms.com`, `uat.voceplatforms.com`, and `git.voceplatforms.com`
    
### Installation

1. Install VirtualBox from [https://www.virtualbox.org/](https://www.virtualbox.org/)
2. Install Vagrant (latest release) from [http://www.vagrantup.com/downloads.html](http://www.vagrantup.com/downloads.html).
3. Ensure 'homebrew' is installed on your system from [http://brew.sh/](http://brew.sh/)
4. Execute setup steps:

    ```
    mkdir -p $HOME/opt
    git clone git@github.com:voceconnect/ansible.git $HOME/opt/ansible
    cd $HOME/opt/ansible
    ./bin/dev setup
    ```

    This step also gets the SSH private key needed to SSH into the virtual machine, installs needed Vagrant plugins, and copies the sample files for editing.

5. Edit the `virtualbox-settings` file and change the values marked `TODO` accordingly.
6. Edit `inventory/host_vars/development.voceplatforms.com.yml` and fill in the following variables:
    * `ghettoAPIKey` - string value of your API key for use with api.voceconnect.com
    * `ansible_ssh_private_key_file` - a string value representing the path to the SSH private key created by ansible.  You need to update to point to your ssh directory.
    * `nginxAssetsMappingEnabled` - set to true by default, this will use NGINX in your virtual machine to attempt to serve missing local assets from an upstream server. set to false if you want static assets to instead throw a 404.
7. Ensure peon is installed from [https://github.com/voceconnect/peon/#initial-installation](https://github.com/voceconnect/peon/#initial-installation)
8. Edit your `$HOME/bin/peon/global/peon-user.json` file and update the "local" settings to point to the virtual machine. Assuming these settings weren't changed in the default `Vagrantfile` or `development.voceplatforms.com` inventory, it'd look like:

    ```json
    "local": {
      "db": {
        "host": "localhost",
        "user": "_root",
        "password": "spam32"
      },
      "ssh": {
        "host": "192.168.33.10",
        "username": "vagrant",
        "password": "vagrant"
      }
    }
    ```

9. Boot up the virtual machine. You will be prompted for your password in order to write to `/etc/exports` so that the VM and the host Mac OS X machine can share folders.

    ```
    cd $HOME/opt/ansible
    vagrant up --provision
    ```

Steps 1 through 8 are one time setup steps that you won't need to repeat.

Step 9 is only executed once to import the machine into Vagrant, moving forward one can use `peon` commands or `vagrant provision` to re-run the Ansible playbooks responsible for keeping the VM configured and up-to-date with project configurations.

## Controlling your virtual machine

The following table outlines what peon commands you can execute and the effect those commands will have on your virtual development environment.

Peon commands can be executed from any directory on your host machine.


Command             | Peon Equivalent | What does it do?
------------------- | --------------- | ----------------
**vagrant up**      | `peon vm-start` | Boots up the development VM
**vagrant halt**    | `peon vm-stop` | Shuts down the development VM
**vagrant provision** | `peon vm-setup` | Re-provisions the entire VM, including applications
**ansible-playbook development.yml -i inventory/development -t 'client:provision'** | `peon vm-update --all` | Re-provisions all applications on your VM
**ansible-playbook development.yml -i inventory/development -t 'client:provision' -e 'application=<APP>'** | `peon vm-update` | Re-provisions a single specific application in the VM, specified by `<APP>` or by pulling the project name from the current working directory

## Setting up a new project

Assuming application data has already been added to `api.voceconnect.com` (or to `inventory/custom/project-name.json`), and assuming the `pnconnect` project has not already been setup locally:

```
## create the new project with peon
cd /path/to/projects
peon-wp-project pnconnect

## start the virtual machine
peon vm-start

## update all virtual machine configurations, which will include the new project
peon vm-setup
```

If your VM is already running, you can skip `peon vm-start`.

## Setting up an existing project

Assuming application data has already been added to `api.voceconnect.com` (or to `inventory/custom/project-name.json`), and assuming the `pnconnect` project has already been setup locally:

```
## start the virtual machine
peon vm-start

## ensure configurations and symlinks are up-to-date with projects you have locally
peon vm-setup

## navigate to the project directory
cd /path/to/projects/pnconnect

## any of these commands can be run, but all may not need to be executed
## just depends on how far the project was setup initially
npm install  
peon setup-wp  
peon build
peon wp-checkout
peon wp-plugins
peon sync-db
```

## Profiling with Webgrind

In the development environment, any request can generate XDebug cachegrind output by adding a request parameter to the query string for `XDEBUG_PROFILE`. For example, any of the following requests would generate cachegrind output:

```
http://voceplatforms.staging.voceconnect.dev/?XDEBUG_PROFILE
http://voceplatforms.staging.voceconnect.dev/?XDEBUG_PROFILE=1
http://voceplatforms.staging.voceconnect.dev/?alpha=bravo&XDEBUG_PROFILE
```

Once you've generated cachegrind data for analyzing, navigate to [http://webgrind.voceconnect.dev](http://webgrind.voceconnect.dev). Select the cachegrind file from the dropdown that by default says `Auto (newest)`. Then click the `Update` button. 

![](http://voce-public.s3.amazonaws.com/ansible/dev-readme-img-3.png)

So what does the Webgrind output mean? Starting with the color bar in the upper right:

* Blue - internal PHP functions
* Grey - calls to 'require' or 'require_once', includes
* Green - class methods
* Orange - procedural functions

The main display consists of a table containing all the function calls, class methods, PHP internals and requires/includes that were executed during the request. 

* Invocation Count - how many times that given function was called
* Total Self Cost - how long did the given function take to execute just by itself
* Total Inclusive Cost - how long did the given function take to execute for itself and all the functions it calls

Ordering by `Total Inclusive Cost` descending will show you the most expensive (time consuming) functions. Clicking on the first one (the most expensive) will expand to show what functions/class methods/requires/includes are called from within that function. From there you can continue to "drill down" noting expensive function calls that could be refactored/optimized. 

Clicking `Show Call Graph` may help to provide a visual means of what parts of the request took the most time, an example can be found [here](http://voce-public.s3.amazonaws.com/ansible/cachegrind.out.21219-10.webgrind.png). By default, showing the call graph is disabled because it requires removing `shell_exec` from the list of PHP's `disabled_functions`. Contact SysOps if you'd like to enable call graphs. 

To prevent the development environment from running out of disk space, cachegrind output older than 2 hours is automatically removed.

**NOTE:** During [very unscientific and brief] testing, the development environment has been shown to add ~600ms-700ms when the request generates cachegrind data, and ~200ms just for having the XDebug module loaded into PHP. In the example screenshot above, the request took ~1.2 seconds, but without generating cachegrind data or having XDebug loaded, the request took ~250ms. YMMV depending on your setup and resources devoted to VirtualBox.

## FAQ

* **My `.dev` DNS doesn't seem to be working, how can I fix?**

    ```
    cd $HOME/opt/ansible
    vagrant dns --stop
    vagrant dns --purge
    vagrant dns --install
    vagrant dns --start
    ```

* **Can I use PHP's `xdebug` remote debugger?**

    Absolutely! It's configured to use port `9000`. Your IDE's settings should be configured to use port `9000`.

* **Can I use `peon sync-db` to import the database into the virtual machine?**

    Yes!

* **Where can I view log files the VM generates?**

    Launch your machine's `Console.app` (typically found in Applications -> Utilities). Messages from the VM will appear in the main pane when "All Messages" or "system.log" is selected in the left pane. If you need to see raw access logs, use `vagrant ssh` to access your VM, then `sudo su -` to gain root privileges. Access logs can be found broken down by application in `/var/log/nginx`.

* **I use Dropbox to store my projects, that are shared with more than one machine. I have several VMs in my VirtualBox install. What gives?**

    When you run `peon vm-start` (or `vagrant up`) it creates a `.vagrant` directory to hold some metadata about the machine as it exists in VirtualBox. Since that directory is sync'd via Dropbox, the other machine gets metadata about a VM it's not aware of. It creates a new `.vagrant` folder, removing/changing the previous set of metadata. Rinse and repeat on each machine until your VirtualBox is full of VMs.

    The recommended solution is to use an environment variable, `VAGRANT_DOTFILE_PATH` to set a path outside of Dropbox. Example:

    ```
    export VAGRANT_DOTFILE_PATH=$HOME/.vagrant
    peon vm-start
    ```

    For persistence, export the environment variable in your `.bashrc`, `.bash_profile` or `.zshrc` file.

* **I want to be able to test or develop an application that doesn't exist in the Voce API. Is there anyway I can do that without needing to have data in `api.voceconnect.com`?**

    Yes! Follow the steps below. We'll call the test project, for example's sake, "politcal.com"

    1) Create a `politcal.json` file in `inventory/custom/`

    2) Populate `politcal.json` with data that matches the structure provided by the `api.voceconnect.com` site. It will help to grab an existing project from the API, then modify the JSON returned to match your custom needs.

    3) `vagrant provision`

## In a nutshell, the development environment...

![](http://voce-public.s3.amazonaws.com/ansible/dev-readme-img-1.png)

Using VirtualBox, Vagrant and Voce's custom Ansible playbooks - the process detailed here sets up a self-contained virtual machine that runs all the components necessary to work on applications (NGINX, php-fpm, memcached, MySQL, etc.).

You start by downloading and installing the pre-requisites, then spin up the virtual machine. The virtual machine that is downloaded already comes pre-configured for NGINX, php-fpm, MySQL, memcached, Redis, MongoDB - everything that powers the applications we currently develop. It's a pre-configured environment that closely matches Voce staging, UAT, and production environments without having to install applications like MAMP, or fiddle with built-in configurations that are inconsistent with higher tier environments.

Once the machine is spun up, projects can be configured. DNS is provided to route `*.voceconnect.dev` domains to your virtual instance. Project files are all kept local on the "host" machine (your Mac OS X) install, then shared via NFS to your virtual machine. This allows you to continue to use your editor/IDE of choice and execute `peon` commands; but routes web requests to the virtual instance.

## Wait, but why?

A few reasons, mostly:

* No more tinkering with local Mac OS X environment setups (Apache, MAMP, etc.)
* No prior knowledge of how to setup/install local Mac OS X dependencies (NGINX, Apache, MySQL, etc.) needed
* Consistency across development environments
* Consistency with production, UAT, and staging environments
* Quick recovery to be back up and running from a drive failure, re-format, or when you're setting up a new machine.
