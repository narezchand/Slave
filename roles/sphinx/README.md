sphinx
========

Setup and configuration of Sphinx SQL search instance.

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

- name: provision sphinx servers...
  hosts: sphinx
  sudo: True
  roles:
    - { role: 'sphinx', tags: [ 'sphinx' ] }

License
-------

MIT
