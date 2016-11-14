supervisor-jobs
========

Setup and configuration of supervisord daemons.

Requirements
------------

None

Role Variables
--------------

See `defaults/main.yml`

Dependencies
------------

* setup

Example Playbook
-------------------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - name: setup...
      hosts: all
      sudo: True
      roles:
        - { role: 'supervisor-jobs', tags: [ 'supervisor-jobs' ] }

License
-------

MIT
