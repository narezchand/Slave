vbulletin
========

Setup and configure vBulletin applications.

Requirements
------------

* `applications` variable containing an array of application instance data.
* `executeFixPermissions` variable (true|false) for whether or not permissions repair scripts should be executed. Defaults to false.

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup
* mariadb (or MySQL equivalent)
* nginx
* php

Example Playbook
-------------------------

    - name: provision web servers...
      hosts: web
      sudo: True
      roles:
        - { role: 'nginx', tags: [ 'nginx' ] }
        - { role: 'php', tags: [ 'php' ] }
        - { role: 'vbulletin', tags: [ 'vbulletin' ] }

License
-------

MIT
