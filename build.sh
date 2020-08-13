BUILD_PKGS="gcc g++ gfortran make omniorb omniidl libomniorb4-dev git autoconf automake libtool cmake default-jre-headless gettext libexpat-dev libblas-dev liblapack-dev liblpsolve55-dev libreadline-dev libncurses5-dev libcurl-dev libqt4-dev libsundials-serial-dev python-pip"
RUNTIME_PKGS="gcc make omniorb omniidl liblapack-dev libblas-dev libncurses5 python-omniorb libsundials-serial"

apt-get update && apt-get install -y ${BUILD_PKGS}

git clone https://github.com/OpenModelica/OpenModelica.git /build/openmodelica || exit 1
cd /build/openmodelica
# After cloning
git checkout master
git pull
git submodule foreach --recursive "git checkout master"
# To update; you will need to merge each submodule, but your changes will remain
git submodule foreach --recursive "git pull"
# Running master on all submodules might lead to build errors
# so use this to make sure you force all submodules to the commits
# from the OpenModelica glue project which are properly tested
git submodule update --force --init --recursive

autoconf && ./configure --prefix=/usr --disable-modelica3d --with-omniORB=/usr && make && make install && pip install OMPython

#apt-get remove --purge -y ${BUILD_PKGS} $(apt-mark showauto)

apt-get install -y ${RUNTIME_PKGS}

#rm -rf /var/lib/apt/lists/*

