php
========

Setup and configuration of PHP. Role also provides optional support for installing PHP-FPM with opcode caching. Other components include:

* XDebug
* PEAR/PECL support
* New Relic PHP agent

Requirements
------------

* `applications` variable containing an array of application instance data.

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup (recommended)
* nginx (if using PHP-FPM)

Example Playbook
-------------------------

    - name: provision web servers...
      hosts: web
      sudo: True
      roles:
        - { role: 'php', tags: [ 'php' ] }

License
-------

MIT
