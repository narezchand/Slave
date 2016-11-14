Pantheon
========

This role ensures that Pantheon's CLI tool, terminus, is installed

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
         - { role: 'pantheon', tags: [ 'pantheon' ] }

License
-------

MIT