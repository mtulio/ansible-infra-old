Ansible Infrastructure
======================

[![CircleCI](https://circleci.com/gh/mtulio/ansible-infra.svg?style=svg)](https://circleci.com/gh/mtulio/ansible-infra)


Overview
========

Main repository to keep configuration management using Ansible.
Ansible version: 2.2


Getting Started
===============

`git clone git@github.com:mtulio/ansible-infra.git --recursive`


ROLES
=====

### LetsEncrypt

certbot-auto certonly -a webroot --webroot-path=/var/www/html/ -d ict-eng.net  -d www.ict-eng.net -d app.ict-eng.net
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

* http://letsencrypt.readthedocs.io/en/latest/using.html
TODO: --csr

---
---

## Useful commands

### Ansible

#### Config

#### Inventory

#### Modules

##### Ping

##### Setup

### GIT

#### Clone recursively 

#### Submodule - ADD

#### Submodule - PULL


