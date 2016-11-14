nodejs
========

Setup and configure node.js applications.

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
* nginx

Example Playbook
-------------------------

    - name: provision web servers...
      hosts: web
      sudo: True
      roles:
        - { role: 'nginx', tags: [ 'nginx' ] }
        - { role: 'nodejs', tags: [ 'nodejs' ] }

License
-------

MIT
