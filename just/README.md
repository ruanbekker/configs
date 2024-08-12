# just

[just](https://github.com/casey/just) is a command runner, similar to `make`.

## Installation

Installation for Linux:

```bash
wget https://github.com/casey/just/releases/download/1.34.0/just-1.34.0-x86_64-unknown-linux-musl.tar.gz
tar -xvf just-1.34.0-x86_64-unknown-linux-musl.tar.gz -C /tmp/
sudo install -o root -g root -m 0755 /tmp/just /usr/local/bin/just
rm -f just-1.34.0-x86_64-unknown-linux-musl.tar.gz
```

## Basic Configuration

You can use `Justfile` or `.justfile` inside the root of your directory:

```bash
ts := `date +%Y%m%d%H%S`

default:
  just --list

plan:
  terraform init
  terraform plan

apply:
  terraform apply
```
