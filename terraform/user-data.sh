#!/bin/bash
set -e
sudo apt-get update
sudo apt-get install -y python3 python-pip virtualenv git ansible
git clone https://github.com/Bincy1234/Bincy_Challenge.git
cd Bincy_Challenge
virtualenv venv --python=/usr/bin/python3 && source venv/bin/activate

pip install -r requirements.txt
cd ansible && ansible-playbook default.yml -e 'ansible_python_interpreter=/usr/bin/python3'
curl -fsSL https://goss.rocks/install | sudo GOSS_DST=/usr/bin sh
cd tests && goss validate > test.html
sudo chown root. test.html && mv test.html /var/www/html/test.html
EOF
