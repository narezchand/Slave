auditd
========

Setup and configuration of 'auditd' for system level auditing. Logs should be analyzed with `ausearch` and `aureport`.

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
        - { role: 'auditd', tags: [ 'auditd' ] }

License
-------

MIT
