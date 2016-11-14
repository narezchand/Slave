push-deploy
========

Setup and configuration of "git-push-to-deploy" with Capistrano

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

    - name: configure and deploy 'git-push-to-deploy' servers...
      hosts: deploy
      sudo: True
      roles:
        - { role: 'push-deploy', tags: [ 'push-deploy' ] }

License
-------

MIT
