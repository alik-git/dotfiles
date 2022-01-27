#!/bin/sh

set -x

# Create a virtual environment 

pip install jupyterlab

pip install --upgrade jupyter_http_over_ws>=0.0.7 && jupyter serverextension enable --py jupyter_http_over_ws

# To run the notebook

# jupyter notebook --NotebookApp.allow_origin='https://colab.research.google.com' --port=8888 --NotebookApp.port_retries=0

# # Go to home directory

# cd ~

# cd /tmp

# # You can change what anaconda version you want at 
# # https://repo.continuum.io/archive/
# curl -Ok https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh

# chmod +x Anaconda3-2021.05-Linux-x86_64.sh

# bash Anaconda3-2021.05-Linux-x86_64.sh

# conda update conda