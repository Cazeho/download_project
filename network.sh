# Access GITALAB with VPN

sudo echo "search gitlab.altrnativ.xyz \n nameserver 10.0.45.54" | tee -a /etc/resolv.conf
#sudo echo "10.0.45.54 gitlab.altrnativ.xyz" | tee -a /etc/hosts
sudo systemctl daemon-reload
sudo /bin/systemctl restart systemd-hostnamed
