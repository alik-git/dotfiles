set -x 

ssh-keygen -t rsa -b 4096 -C alihusein.kuwajerwala@umontreal.ca

xclip -sel clip < ~/.ssh/id_rsa.pub

echo "New SSH key made and copied to clipboard"