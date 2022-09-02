apt install slapd ldap-utils



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
