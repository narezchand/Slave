setup
========

Basic setup tasks for any system, including:

* Installation of common/required packages
* NTP
* Management of /etc/hostname and /etc/hosts
* TCP Tuning
* Management of network interfaces
* SSH setup
* rsyslog
* sudoers and settings
* root user, system level users
* Ruby
* NPM
* Ansible
* Cron jobs
* UFW
* ZSH with https://github.com/robbyrussell/oh-my-zsh

Requirements
------------

None

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

None

Example Playbook
-------------------------

    - name: provision common server requirements...
      hosts: all
      sudo: True
      roles:
        - { role: 'setup', tags: [ 'setup' ] }

License
-------

MIT
