
#!/bin/bash

# Installation de docker sur Rocky Linux 9 (define Security)



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
    dnf update -y > /dev/null
    dnf -y install dnf-plugins-core > /dev/null
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo > /dev/null
    dnf update -y > /dev/null
    

    
}


docker_compose_install() {
     dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null
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
    echo "[INFO] installation de docker && docker-compose --> OS : ROCKY"

    if [[ "$(get_distribution)" == "rocky" ]]; then
        echo "[INFO] is rocky distro"
    else
        echo "[FAIL] not rocky"
        exit 1
    fi

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
