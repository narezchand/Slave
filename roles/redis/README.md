redis
========

Setup and configure a single or multiple redis instances.

Requirements
------------

None

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup (recommended)

Example Playbook
-------------------------

    - name: provision redis servers...
      hosts: redis
      sudo: True
      roles:
        - { role: 'redis', tags: [ 'redis' ] }

License
-------

MIT
