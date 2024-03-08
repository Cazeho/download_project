#!/bin/bash

# Installation de docker sur UBUNTU 22.04



#fingerprint

get_distribution() {
	os=""
    os_version=""
	# Every system that we officially support has /etc/os-release
	if [ -r /etc/os-release ]; then
		os="$(. /etc/os-release && echo "$ID")"
        os_version="$(. /etc/os-release && echo "$VERSION_ID")"

	fi
	# Returning an empty string here should be alright since the
	# case statements don't act unless you provide an actual value
	echo "$os"
}


docker_install() {
    apt-get update -y > /dev/null
    apt-get install jq ca-certificates curl gnupg lsb-release -y > /dev/null
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg > /dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update -y > /dev/null
}


docker_compose_install() {
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y > /dev/null
    version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".tag_name")
    curl -SL https://github.com/docker/compose/releases/download/$version/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose &> /dev/null
    chmod +x /usr/local/bin/docker-compose > /dev/null
}


check_install() {
    if ! docker --version &> /dev/null; then
	    echo "[FAIL INSTALL]"
	    exit 1
    else
        echo "[SUCCESS INSTALL] !!!"
    fi
}


main () {
    echo "[INFO] installation de docker && docker-compose --> OS : UBUNTU"

    
    if [[ $EUID -ne 0 ]]; then
        echo "[FAIL] This script must be run as root or with sudo privileges" 
        exit 1
    fi

    docker_install
    if [ $? -ne 0 ]; then
       echo "[FAIL] installation docker"
       exit 1
    else
       echo "[SUCCESS] installation docker"
    fi

    docker_compose_install
    if [ $? -ne 0 ]; then
        echo "[FAIL] installation docker-compose"
        exit 1
    else
        echo "[SUCCESS] installation docker-compose"
    fi
    
    check_install
}


main
