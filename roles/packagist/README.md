packagist
========

Setup and configuration of a WordPress "packagist" clone (https://github.com/outlandishideas/wpackagist, https://github.com/voceconnect/voce-packagist). "Packagist" is used by composer for retrieving metadata about project dependencies.

Requirements
------------

None

Role Variables
--------------

None

Dependencies
------------

* setup
* nginx

Example Playbook
-------------------------

    - name: configure and deploy packagist servers...
      hosts: packagist
      sudo: True
      roles:
        - { role: 'packagist', tags: [ 'packagist' ] }

License
-------

MIT
