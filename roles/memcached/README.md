memcached
========

Setup and configuration of a memcached daemon

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

    - name: provision memcached servers...
      hosts: memcached
      sudo: True
      roles:
        - { role: 'memcached', tags: [ 'memcached' ] }

License
-------

MIT
