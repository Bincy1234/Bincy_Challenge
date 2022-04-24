##Provisioning


Web server is provisioned using [Ansible](https://www.ansible.com/).
The Ansible role installs an ngnix server, enables rewrite module,
copies html file and config file which redirect HTTP requests it receives on
port 80 to HTTPs on port 443.


##Testing
[goss](https://github.com/aelsabbahy/goss)is used to test the infrastructure
configuration.
