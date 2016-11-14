mariadb
========

Setup and configuration for MariaDB MySQL drop-in.

Requirements
------------

MySQL configuration templates are applied using the `mysqlConfiguration` variable. For example, with `mysqlConfiguration`, Ansible will look to apply the template named `etc-mysql-conf.d-development.cnf.j2`. By default, the `mysqlConfiguration` variable is set to the total RAM for a host, allowing setup of configurations tuned to use specific amounts of memory.

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup (recommended)

Example Playbook
-------------------------

    - name: provision database servers...
      hosts: database
      sudo: True
      roles:
        - { role: 'mariadb', tags: [ 'mariadb' ] }

License
-------

MIT
