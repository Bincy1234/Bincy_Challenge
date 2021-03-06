#!/bin/bash
set -e
sudo apt-get update
sudo apt-get install -y python3 python3-pip virtualenv git vim curl
git clone https://github.com/Bincy1234/Bincy_Challenge.git
cd Bincy_Challenge
virtualenv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
cd ansible
echo ${var.vault_password} > ~/.vault_pass.txt
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
ansible-playbook default.yml
curl -fsSL https://goss.rocks/install | sudo GOSS_DST=/usr/bin sh
cd tests
goss validate --format documentation > test.html
sudo chown root. test.html
sudo mv test.html /var/www/static_web_app/test/test.html
EOF
