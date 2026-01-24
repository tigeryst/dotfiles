#!/usr/bin/env bash
set -eu

echo "Setting up Python with pyenv..."

pyenv install 3
pyenv global 3
pyenv rehash

pip install --upgrade pip
pip install --upgrade setuptools

pip install virtualenv

pipx ensurepath
pipx install sqlfluff

conda init zsh
conda config --set auto_activate_base false

mamba shell init --shell zsh