##Provisioning


Web server is provisioned using [Ansible](https://www.ansible.com/).
The Ansible role [static_web_app] installs an ngnix server,
copies html file which display Hello World and config file which redirect HTTP requests it receives on
port 80 to HTTPs on port 443.

#add config to listen to https
