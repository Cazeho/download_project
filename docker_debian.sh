#docker (debian)

apt install jq -y
apt update -y
apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y


#docker-compose
version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r ".tag_name")


curl -SL https://github.com/docker/compose/releases/download/$version/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
