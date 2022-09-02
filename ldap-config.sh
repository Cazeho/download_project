apt install slapd ldap-utils

dpkg-reconfigure slapd



dn: ou=Users,dc=visio,dc=cazeho,dc=ovh
objectClass: organizationalUnit
ou: Users


dn: cn=binduser,ou=Users,dc=visio,dc=cazeho,dc=ovh
objectClass: posixGroup
cn: binduser
gidNumber: 5001


dn: uid=prenom,ou=Users,dc=visio,dc=cazeho,dc=ovh
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: prenom
sn: nom
givenName: prenom
cn: prenom nom
displayName: prenom nom
uidNumber: 10001
gidNumber: 5001
loginShell: /bin/bash
homeDirectory: /home/prenom
userPassword: password


ldapadd -x -D cn=admin,dc=visio,dc=cazeho,dc=ovh -W -f add_content.ldifl



echo "ENABLE_AUTH=1" >> .env
echo "AUTH_TYPE=ldap" >> .env
echo "LDAP_AUTH_METHOD=bind" >> .env
echo "LDAP_URL=ldap://ldap.root101.net/" >> .env
echo "LDAP_BINDDN=CN=jitsiuser,OU=ConfAdmins,OU=HumanAccounts,OU=Accounts,DC=root101,DC=lokal" >> .env
echo "LDAP_BASE=OU=ConfAdmins,OU=HumanAccounts,OU=Accounts,DC=root101,DC=lokal" >> .env
echo "LDAP_BINDPW=PASSr101" >> .env



