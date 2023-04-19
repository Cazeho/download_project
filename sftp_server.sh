adduser sftpuser

mkdir /var/sftp
chown root:root /var/sftp
chmod 755 /var/sftp
mkdir /var/sftp/files
chown sftpuser:sftpuser /var/sftp/files
chmod 755 /var/sftp/files

sudo nano /etc/ssh/sshd_config


comment: # Subsystem      sftp    /usr/lib/openssh/sftp-server

add: PasswordAuthentication yes

Subsystem sftp internal-sftp

Match User sftpuser
    ChrootDirectory /var/sftp
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no
    
    
    
systemctl restart ssh

