# Synology Stuff
## Setup shared folder on Synology

To mount a volume/shared folder from your Synology device on your PC, follow these steps:

1. Enable NFS share on the desired volume/shared folder. You can find instructions on how to do this.
2. Once you have a shared folder, access the Synology QuickConnect webpage.
3. Go to Control Panel -> Shared Folder and select the folder you want to connect to.
4. Right-click on the folder and choose "Edit" -> "NFS Permissions."
5. Verify that the IP address of the PC you want to mount the share on is listed under "Client IP" and ensure that the "Squash" setting is set to "Map all users to admin."
6. To check the IP address of your PC, open the terminal and enter `ip addr show`. Look for the entry corresponding to your Ethernet connection (usually denoted as "en").

## Mount the share on your PC
You should now be able to successfully mount the Synology share on your computer using the following command in the terminal:

```
sudo mount -t nfs [IP address of NAS]:/volumeN/path/to/shared/folder /home/user/mountpoint
```

To find the IP address of the NAS, follow these steps in the Synology QuickConnect webUI:
1. Go to Control Panel -> Network -> Network Interface -> LAN.

## Automatically mount on boot
You can configure the share to mount on boot by editing the fstab file. Here's a tutorial for reference: [Tutorial Link](https://linuxize.com/post/how-to-mount-an-nfs-share-in-linux/)

To add the entry to the fstab file, follow these steps:
1. Open the terminal and enter `sudo nano /etc/fstab`.
2. Add a helper comment line: 
```
# [NFS server IP address]:[mount path] [mount point] nfs defaults 0 0
```
3. Add the actual line 
```
[IP address of NAS]:/volume[N]/[shared folder] /home/[user]/[mount point] nfs defaults 0 0
``` 
to the end of the file.

That's it! The share will now be automatically mounted on boot.