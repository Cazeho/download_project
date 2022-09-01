#jitsi-docker

#get latest version of the stable release

version=$(curl -s https://api.github.com/repos/jitsi/docker-jitsi-meet/releases/latest | jq -r ".tag_name")


#download jitsi

#tarball_file=$(curl -s https://api.github.com/repos/jitsi/docker-jitsi-meet/releases/latest | jq -r ".tarball_url")

#wget $tarball_file



tarball_file=https://github.com/jitsi/docker-jitsi-meet/archive/refs/tags/$version.tar.gz

wget $tarball_file


tar -zxvf $version.tar.gz
