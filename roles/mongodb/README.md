mongodb
========

Setup and configuration of the NoSQL database MongoDB.

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

    - name: configure and deploy mongodb servers...
      hosts: mongodb
      sudo: True
      roles:
        - { role: 'mongodb', tags: [ 'mongodb' ] }

License
-------

MIT
