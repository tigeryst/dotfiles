#!/usr/bin/env bash

pyenv install 3
pyenv global 3
pyenv rehash

pip install --upgrade pip
pip install --upgrade setuptools

pip install pipenv
