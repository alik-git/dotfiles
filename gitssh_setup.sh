ssh-keygen -t rsa -b 4096 -C aliqk1603@gmail.com

apt-get install xclip

xclip -sel clip < ~/.ssh/id_rsa.pub

echo "New SSH key made and copied to clipboard"