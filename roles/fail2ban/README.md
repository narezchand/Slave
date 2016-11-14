fail2ban
========

Setup and configuration of 'fail2ban' for IP address blocking. This role copies all the files in `files/etc-fail2ban-action.d` and `files/etc-fail2ban-filter.d` to each host. A specific host_var for `fail2banFilters` allows control over which hosts use which filters and actions.

Requirements
------------

* iptables

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup (recommended)

Example Playbook
-------------------------

    - name: provision common server requirements...
      hosts: all
      sudo: True
      roles:
        - { role: 'fail2ban', tags: [ 'fail2ban' ] }

License
-------

MIT
