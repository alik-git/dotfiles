# Synology Stuff

You need to enable NFS share on the volume/shared folder you want to mount on the Pc, you can look up how to do this. 

In the NFS permissions of the shared folder, the squash setting needs to be "Map all users to admin" and the Client Ip needs to be the ip of the PC you want to mount the share on. You can find the ip by doing `ip addr show` in the terminal, and seeing the en for ethernet.

You can then mount the share by doing `sudo mount -t nfs [IP adrr of NAS]:/path/to/shared/folder /home/user/mountpoint`

To find the ip of the NAS, in the quickconnect webUI for the Synology, its in Control Panel, Network, Network Interface, LAN. 

## Mount on boot
https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/
You can also add this to your fstab file so that it mounts on boot. You can do this by doing `sudo nano /etc/fstab` and adding a helper comment line: `# [NFS server IP address]:[mount path] [mount point] nfs defaults 0 0` and then the actual line `[ip of nas]:/volume[N]/[shared folder] /home/[user]/[mount point] nfs defaults 0 0` to the end of the file.

