# Shrink Debian by removing all graphical features to turn it into a headless server

For YaCy, no online graphical interface is needed. Because YaCy starts automatically with a headless-option, only a headless java (i.e. package openjdk-7-jre-headless) is required and we can safely remove all graphics drivers from debian.

## Delete Packages for Graphics
As root, simply do

```
apt-get remove --purge libx11-6
```

followed by a clean-up

```
apt-get autoremove --purge
sudo apt-get clean
```

This will remove many packages, but to get debian really clean, remove unused packages as well. This should include all non-headless applications. Some can be discovered automatically, see next section.

## Orphaned Package Removal

Because some unused packages do not necessarily have dependencies to removed packages, we need a tool to discover such orphaned packages:

```
apt-get install deborphan
deborphan
deborphan --guess-all
```

You can easily remove all packages which deborphan reports with

```
apt-get remove --purge `deborphan`
apt-get remove --purge `deborphan --guess-all`
apt-get autoremove --purge
```

Repeat this until no more packages are deleted, then do a

```
apt-get clean
```

## Remove Large Packages

This goes beyond removal of non-headless software but might be useful to further shrink debian to get away large and unused software. You can easily discover large packages with

```
dpkg-query -W --showformat='${Installed-Size} ${Package} [depends: ${Depends}]\n' | sort -n 
```

which lists each package with occupied kilobytes, the package name and the dependencies for that package. A good starting point is the removal of large packages with many dependencies because chances are high that then again orphaned packages appear which can be removed with the 'Orphaned Package Removal' from last section.

## Remove Software with Large Runtime

Some software on your server may consume a lot of CPU time. If some of these processes are of no use for you, you can delete them. To discover such processes, run

```
top -bn1 | grep root | sort -k11
```

Whenever you removed more packages, run the 'Orphaned Package Removal' process again.

## Remove Old Kernel Modules

Kernel modules take up a large disk space and can easily be removed. To ensure that you are doing the right thing, first check which kernel you are running with

```
uname -r
```

Then you can look for the modules which are stored with

```
ls /lib/modules
```

Finally remove the modules, which are not identical to the one as discovered with uname -r using i.e.

```
apt-get remove --purge 3.5.0-17-generic
```

and so on for all old kernel. This will free about 100MB of disk space for each kernel.

## Search for installed packages

Whenever you want to remove a package, you must know the name of that package. The package names of all installed packages can be listed with

```
dpkg --get-selections
```

This can be useful i.e. if you want to see if you have two versions of the same tool, i.e.

```
dpkg --get-selections *jre*
```

may show you that you have installed jre-6 and jre-7, so you can remove one of them. You can also remove all linux source headers files, search for *headers* which will free a large amount of space.

## Prepare for tiny VirtualBox ova Appliance Dumps

To further shrink the debian installation (i.e. to prepare an appliance dump in VirtualBox), it makes sense to remove more never-used applications and data.

### Reduce Data

http://wiki.debian.org/ReduceDebian has some hints to reduce debian, this is what removes most of the remaining data:

```
rm -Rf /usr/share/locale
rm -Rf /usr/share/doc
rm -Rf /usr/share/man
```

As a very last step you can also delete the package lists

```
rm -r /var/lib/apt/lists
```

.. which will free about 100MB of disk space. The lists directory is recreated the next time you run apt-get update.

### Wipe Out Empty Space

When you export a virtual machine to a ova Appliance dump, the virtual disk is compressed. To enhance this process, it is necessary to zero all empty disk space. The easiest way to do this is:

```
dd if=/dev/zero of=/emptyspace
rm -rf /emptyspace
```

### Shrink Virtual Disk Image

VirtualBox has some command-line tools, this is what you would like to do to reduce the disk size after you wiped out the empty space:

```
VBoxManage modifyhd --compact my_disk_image.vdi
```

In case that you created the virtual machine from a ova dump, you probably don't have a vdi file but a vmdk file. This cannot be shrinked with VBoxManage, but you can create a vdi file out from the vmdk which can be shrinked then:

```
VBoxManage clonehd --format vdi my_disk_image.vmdk my_disk_image.vdi
```

When doing this, you must assign the new disk to the virtual machine in the VirtualBox GUI. However, a shrinked vmdk file is mostly smaller than a shrinked vdi file, therefore it does not make sense to apply this on an already shrinked appliance.