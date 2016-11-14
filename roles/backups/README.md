backups
========

Provides packages and configs for backups with duplicity to an S3 bucket.

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

    - name: provision common server requirements...
      hosts: all
      sudo: True
      roles:
        - { role: 'backups', tags: [ 'backups' ], when: backupsEnabled }

License
-------

MIT
