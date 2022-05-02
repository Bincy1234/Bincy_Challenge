# Provisioning


The Ansible role `static_web_app`

* Installs an ngnix server
* Copies content of html file which display Hello World to the Server
* Updates config file to listen to http and https request, update ssl certs for
HTTPS request, redirect HTTP requests it receives on port 80 to HTTPs on port 443
and to dispaly `HelloWorld` html at https://localhost/ and test results at
https://localhost/test/

## Steps to run the Ansible role

### Pre-requisites

* Make sure the following tools are installed.

1. python3
2. python-pip
3. virtualenv

* Create a python virtual environment and install ansible and dependent packages.

  ```
  virtualenv .venv
  source .venv/bin/activate
  pip install -r requirements.txt

  ```
* Set ansible vault password as environment variable

  ```
  echo "<vault_password>" > ~/.vault_pass.txt
  export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt

  ```

### Execute

  ```
  ansible-playbook default.yml

  ```

## Steps to test the Ansible role.
Configuration testing on the Web Server is done using goss[].


### Pre-requisites
* Install goss

### Execute
  ```
  goss validate --format documentation
  ```
