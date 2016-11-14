nginx
========

Setup and configuration of an NGINX server. 

Requirements
------------

* `applications` variable containing an array of application instance data.
* `nginxHtpasswdUsers` array containing all the username and passwords for users that need access to wp-admin when htpasswd auth is required.

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup

Example Playbook
-------------------------

    - name: provision web servers...
      hosts: web
      sudo: True
      roles:
        - { role: 'nginx', tags: [ 'nginx' ] }

License
-------

MIT
