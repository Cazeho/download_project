cd /opt 
curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' > ~/.profile
source ~/.profile
go version
