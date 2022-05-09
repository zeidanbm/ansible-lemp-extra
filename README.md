# Info
LEMP Stack (Linux, NGINX + Modsec, MariaDB, and PHP), phpMyAdmin, iptable configuration, ssh, Certbot, Clamav virus scanner, fail2ban, node.js, Wordpress and much more roles on a Linux Ubuntu using Ansible.

## Choose the roles you want
You are advised to keep the initialize playbook as is and then choose what you want from the provision.yml playbook. Be careful that some roles depend on the existance of others.

## Configure vars
Set all the vars you need in `vars/all.yml`

## Securing vars
You can use Ansible Vault to encrypt/decrypt your vars file. Also, for user passwords, they can be hashed using a salt as well.

## Required files
For ssh to work, your public key should exist in the ssh role files directory with the name `id_rsa.pub`. Also, if you want to use mysql-restore role, which automatically creates a database and restores the database from a `.sql` file placed in the `mysql-restore/files` directory with the name `wordpress_db.sql`.

## Configuring SSH
The ssh port is set to 2298 and to change it, you need to change the iptables configuration and the sshd config file to match the port you want. If you want the iptables to restrict ssh logins to only your ip address, you need to modify the `iptables/files/firewall.sh` file. The comments in the file will explain what need to be done.

## Host Configuration
Edit the `hosts` file to add your server ip address and adjust the connection vars as needed.

## Initialize
Run the initialize playbook with the root user, using a password stored in the vars file. Adjust `remote_user` in the `initialize.yml` file to match your server root username.

## Provision
At this point your ssl certificate is installed on the server and you can switch and run this file as your admin user. Adjust the `remote_user` in the provision.yml file to match your server admin username. Don't forget to comment out any roles that you don't want to use.