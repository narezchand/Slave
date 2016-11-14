postfix
========

Adds Postfix and configurations used for outbound mail delivery.

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
        - { role: 'postfix', tags: [ 'postfix' ] }


License
-------

MIT
