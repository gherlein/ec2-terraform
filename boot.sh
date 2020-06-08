#!/usr/bin/env bash

apt-get update
apt install -y git 
apt install -y build-essential 
apt install -y direnv 
apt install -y emacs-nox 
apt install -y linuxbrew-wrapper 
apt install -y apt-transport-https
useradd -m gherlein

# Anything else you want to do to set up your user account
