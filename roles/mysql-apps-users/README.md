mysql-apps-users
========

Adds MySQL databases and users. Exists as a separate role so that databases and users can be added regardless of whether MariaDB or Percona is used, and/or to only add users to a replication master.

Requirements
------------

* `mysqlAppsUsersData` variable containing an array MySQL users and databases to add for each application.

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup
* mariadb OR percona role

Example Playbook
-------------------------

    - name: provision database server...
      hosts: database
      sudo: True
      roles:
        - { role: 'mariadb', tags: [ 'mariadb' ] }
        - { role: 'mysql-apps-users', tags: [ 'mysql-apps-users' ] }

License
-------

MIT
