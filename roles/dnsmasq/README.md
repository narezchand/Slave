dnsmasq
========

Setup a local instance of dnsmasq for internal domain resolving. Primarily used for any given server to see an application it hosts using an internal IP address as opposed to resolving the IP publicly.

Requirements
------------

* `applications` variable containing an array of application instance data.

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
        - { role: 'dnsmasq', tags: [ 'dnsmasq' ] }

License
-------

MIT
