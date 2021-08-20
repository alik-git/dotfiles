systemctl daemon-reload
systemctl enable mnt-MyStuff.mount
systemctl enable mnt-MyStuff.automount
systemctl start mnt-MyStuff.mount
systemctl start mnt-MyStuff.automount