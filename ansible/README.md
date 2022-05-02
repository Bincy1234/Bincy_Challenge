# Provisioning


The Ansible role `static_web_app` does the following -

  * Installs an ngnix server.
  * Copy content of the html file which display Hello World to the Server.
  * Updates config file to listen to http and https request, update ssl certs for
    HTTPS request, redirect HTTP requests it receives on port 80 to HTTPs on port 443
    and to display `HelloWorld!` html at https://localhost/ and test results at
    https://localhost/test/.

    ---
    ***Note:***
      The connection between client and server is made secured using SSL handshake.
      The private key used for encryption/decryption is encrypted and stored in
      source control using [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html).

    ---
## Steps to run the Ansible role

### Pre-requisites


  * Make sure the following tools are installed.

  1. python3
  2. python-pip
  3. virtualenv

  * Create a python virtual environment and install ansible and its dependent packages.

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

  Configuration testing on the Web Server is done using [goss](https://github.com/aelsabbahy/goss/blob/master/docs/manual.md).


### Pre-requisites
  * Install goss

### Execute
  *   goss validate and results are stored to an html file.

      ```
      goss validate --format documentation > test.html

      ```


### validate

  * curl -k  https://localhost/ should display the following

      ```
      <html>
        <head>
          <title>Hello World</title>
        </head>
        <body>
          <h1>Hello World!</h1>
        </body>
      </html>

      ```

  * curl -k  https://localhost/test/ displays goss test result.
