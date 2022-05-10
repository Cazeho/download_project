# Access GITALAB with VPN

sudo echo "10.0.45.54 gitlab.altrnativ.xyz" | tee -a /etc/hosts
sudo systemctl daemon-reload
sudo /bin/systemctl restart systemd-hostnamed
