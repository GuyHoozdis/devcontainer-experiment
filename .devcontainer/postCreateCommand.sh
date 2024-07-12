#!/usr/bin/env bash

set -eou pipefail

########################################################################
# TODO: Give this script some proper hardening.  Probably don't need to
# go Google Bash Template, but certainly the basics.
########################################################################

# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

RED='\033[0;31m'
GREEN='\033[0;32m'
END='\033[0m'

echo -e "[${GREEN}*${END}] ${RED}All your postCreateCommand are belong to us${END}!"

# ???: Why does the container need this sometimes, but not others?
# git config --global --add safe.directory /workspaces/devcontainer-experiment
