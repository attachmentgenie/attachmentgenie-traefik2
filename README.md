# attachmentgenie-traefik2

> [!NOTE]
> This is a security-hardened fork of the original [attachmentgenie/puppet-traefik2](https://github.com/attachmentgenie/attachmentgenie-traefik2) module. All credit for the baseline codebase goes to the original author, attachmentgenie.

[![](https://img.shields.io/puppetforge/pdk-version/attachmentgenie/traefik2.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/traefik2)
[![](https://img.shields.io/puppetforge/v/attachmentgenie/traefik2.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/traefik2)
[![](https://img.shields.io/puppetforge/dt/attachmentgenie/traefik2.svg?style=popout)](https://forge.puppetlabs.com/attachmentgenie/traefik2)
[![Spec Tests](https://github.com/attachmentgenie/attachmentgenie-traefik2/actions/workflows/spec.yml/badge.svg)](https://github.com/attachmentgenie/attachmentgenie-traefik2/actions/workflows/spec.yml)
[![License](https://img.shields.io/github/license/attachmentgenie/attachmentgenie-traefik2?stype=popout)](https://github.com/attachmentgenie/attachmentgenie-traefik2/blob/master/LICENSE)

Deploy and configure traefik2 on a node.

- [Description](#description)
- [Usage](#usage)
- [Reference](#reference)
- [Changelog](#changelog)
- [Limitations](#limitations)
- [Development](#development)

## Description

Traefik is an open-source Edge Router that makes publishing your services a fun and easy experience. It receives requests on behalf of your system and finds out which components are responsible for handling them.

## Usage

All options and configuration can be done through interacting with the parameters
on the main traefik2 class.
These are now documented via [Puppet Strings](https://github.com/puppetlabs/puppet-strings)

You can view example usage in [REFERENCE](REFERENCE.md).

## Reference

See [REFERENCE](REFERENCE.md).

## Hardening & De-rooting (Fork Enhancements)

This fork contains critical security enhancements to run Traefik as a secure, unprivileged system user instead of `root`.

### Features
* **Unprivileged Execution:** The Traefik process runs under a dedicated `traefik` user and group.
* **Privileged Ports:** Ambient capabilities (`CAP_NET_BIND_SERVICE`) are assigned to the systemd service unit. This allows the unprivileged Traefik process to bind directly to standard web ports (80 and 443) without root access.
* **Configuration Security:** Configuration files are restricted with `0640` permissions, ensuring only the `traefik` process and root can read them.

### New Class Parameters
You can configure the user and group settings via the main `traefik2` class:

* `user`: The system user name (default: `'traefik'`).
* `group`: The system group name (default: `'traefik'`).
* `manage_user`: Boolean to control whether the module creates the system user and group account (default: `true`).

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

### Running tests

This project contains tests for both rspec-puppet and litmus to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart:

```
pdk bundle install
pdk bundle exec rake 'litmus:provision_list[puppet8]'
pdk bundle exec rake 'litmus:install_agent[puppet8]'
pdk bundle exec rake 'litmus:install_module'
pdk bundle exec rake 'litmus:acceptance:parallel'
pdk bundle exec rake 'litmus:tear_down'
```
