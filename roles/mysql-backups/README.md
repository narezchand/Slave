mysql-backups
========

Setup and configuration of the Holland MySQL backup application.

Requirements
------------

None

Role Variables
--------------

None

Dependencies
------------

* setup (recommended)
* mariadb OR percona

Example Playbook
-------------------------

    - name: provision database backup servers...
      hosts: database_backups
      sudo: True
      roles:
        - { role: 'mysql-backups', tags: [ 'mysql-backups' ] }

License
-------

MIT
