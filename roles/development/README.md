development
========

Setup and configuration of development environment specific tasks.

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

    - hosts: all
      roles:
         - { role: 'development', tags: [ 'development' ] }

License
-------

MIT
