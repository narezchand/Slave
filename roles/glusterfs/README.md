glusterfs
========

This role only ensures the correct client folders exist on a GlusterFS volume. 

Formatting and provisioning of disks, probing Gluster peers, creating GlusterFS storage volumes are all tasks that don't lend themselves to the idempotent nature of Ansible. Those steps would need to be executed outside of Ansible, typically during machine provision for relevant hosts. 

Rackspace GlusterFS Setup
------------

Steps 1-4 only need to be performed if the disk hasn't already been formatted

1. Create new network called "GlusterNet" in the same DC as servers that will utilize Gluster. Set the CIDR to `192.168.3.0/24`
2. Create block storage volumes (one for each server you wish to attach a Gluster brick to). Set partition to `/dev/xvdg` under 'Advanced' (or desired value)
3. Once block storage is attached, execute `fdisk /dev/xvdg` on each server that has attached block storage. Select `'n', 'p', 1, [enter], [enter], 'w'`. 
4. On each server with the attached block storage, execute: 

    ```
    mkfs.ext4 -j /dev/xvdg1
    ```

5. Add the mount to `/etc/fstab`:
    
    ```
    /dev/xvdg1      /glusterfs/brick ext4   defaults        1       2
    ```

6. Create the directory `mkdir -p /glusterfs/brick`
7. Execute `mount -a`, this should now mount `/dev/xvdg1` to `/glusterfs/brick`.
8. Ensure GlusterNet interfaces are brought up, GlusterFS host data is added to `/etc/hosts`, Communication between Gluster bricks is allowed through the firewall.
9. Install `glusterfs-server` and/or `glusterfs-client` packages.
10. On the first GlusterFS brick, probe the other bricks with `gluster peer probe [otherhost]`. Do not probe the first server _from_ the first server.
11. Create the GlusterFS storage volume. In the example below, the "bricks" are identified over the network as "storage1" and "storage2" (defined in `/etc/hosts`). This command should only be executed from the same server used in step 10.

    ```
    gluster volume create storage replica 2 transport tcp storage1:/glusterfs/brick storage2:/glusterfs/brick
    ```

12. Start the storage volume with `gluster volume start storage` and check output with `gluster volume info`

### On GlusterFS clients

1. Create mount point directory `mkdir /storage`
2. Mount the partition on each server by connecting to it. e.g. on `web1`, execute: `mount -t glusterfs storage1:storage /storage`. On `web2` run `mount -t glusterfs storage2:storage /storage` and so on.

### WARNING

Never write files directly to the `/glusterfs/brick` directory on any machine that acts as a GlusterFS brick (storage nodes). Always mount the GlusterFS point first, then add files to that folder.

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

    - name: provision gluster fs servers...
      hosts: glusterfs
      sudo: True
      roles:
        - { role: 'glusterfs', tags: [ 'glusterfs' ] }

License
-------

MIT
