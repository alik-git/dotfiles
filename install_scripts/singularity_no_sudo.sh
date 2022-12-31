set -x
echo "First run install_scripts/go_w_sudo.sh to install go"

go get -u github.com/golang/dep/cmd/dep

go get -d github.com/sylabs/singularity

export VERSION=v3.0.3 && cd $GOPATH/src/github.com/sylabs/singularity && git fetch && git checkout $VERSION 

./mconfig &&     make -C ./builddir &&     sudo make -C ./builddir install

singularity --version