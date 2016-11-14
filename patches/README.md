## patches

### 000-item-name-in-output.patch

This patch updates Ansible's callbacks.py file to instead display just the name of an "item" as opposed to the entire contents of an "item". Mostly used to provide cleaner output by just displaying an application's name, instead of the entirety of data that comes with an application and its instances from the `ghetto_facts` script. Apply the patch with the below commands, assuming `1.8.1` is the version of Ansible the patch should be applied to.

```
cd $(brew --prefix)/Cellar/ansible/1.8.1/libexec/lib/python2.7/site-packages/ansible/
patch < $HOME/opt/ansible/patches/000-item-name-in-output.patch
```
