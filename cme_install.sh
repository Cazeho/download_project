#!/bin/bash

apt update -y
apt-get install -y libssl-dev libffi-dev python-dev-is-python3 build-essential python3-pip unzip

wget https://github.com/mpgn/CrackMapExec/archive/refs/tags/v6.0.1.zip
unzip v6.0.1.zip
cd CrackMapExec-6.0.1
pip install poetry
poetry install
