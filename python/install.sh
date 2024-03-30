#!/usr/bin/env bash

echo "Setting up Python with pyenv..."

pyenv install 3
pyenv global 3
pyenv rehash

pip install --upgrade pip
pip install --upgrade setuptools

pip install pipenv
