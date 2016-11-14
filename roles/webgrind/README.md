webgrind
========

Sets up a webgrind instance for analyzing XDebug profiling output

Requirements
------------

None

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup
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
        - { role: 'webgrind', tags: [ 'webgrind' ] }

License
-------

MIT
