# homelab-infra

Ansible playbooks for managing homelab hosts.

## Setup

Copy `inventory.example` to `inventory` and fill in your hosts. Copy `ansible/.env.example` to `ansible/.env` and set your variables. The `ansible.cfg` assumes a dedicated `ansible` user with an SSH key at `~/.ssh/ansible`.

## Playbooks

| Playbook | Description |
|---|---|
| `bootstrap-user.yml` | Creates the `ansible` user, installs its SSH key, and configures passwordless sudo. Run this first on new hosts using a pre-existing admin user. |
| `update-hosts.yaml` | Runs a full package upgrade on all hosts (apt or dnf). |
| `apply-required-reboots.yaml` | Checks for pending reboots and applies them if needed. |
| `cleanup-hosts.yaml` | Removes unused packages, cleans package caches, vacuums old journal logs, and removes crash dumps. |
| `configure-node-exporter.yaml` | Installs and enables Prometheus node exporter and opens port 9100. |

## Usage

```bash
# Bootstrap a new host (run as an existing admin user)
source .env
ansible-playbook bootstrap-user.yml --limit <host> --user <admin-user> --ask-become-pass --ask-pass

# Run any other playbook
ansible-playbook update-hosts.yaml
ansible-playbook update-hosts.yaml --limit <host>
```
