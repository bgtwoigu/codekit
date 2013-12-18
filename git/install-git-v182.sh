sudo apt-get install libcurl4-openssl-dev build-essential autoconf
git clone https://github.com/git/git
cd git
git tag
git checkout v1.8.2
make configure
./configure –with-openssl
make prefix=/usr/local all
sudo make prefix=/usr/local install
whereis git
git --version
/usr/bin/git --version
/usr/local/bin/git --version
