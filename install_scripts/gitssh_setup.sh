set -x 

ssh-keygen -t rsa -b 4096 -C ali.kuwajerwala@mail.utoronto.ca

xclip -sel clip < ~/.ssh/id_rsa.pub

echo "New SSH key made and copied to clipboard"