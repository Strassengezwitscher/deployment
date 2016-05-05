#!/bin/bash

set -e
set -u

ARGC=$#

if [ $ARGC -ne 1 ]; then
    printf "Usage:\n"
    printf "\t $0 <playbook file>\n"
    printf "\n"
    printf "\t Example:\n"
    printf "\t $0 complete.yml\n"
    printf "\n"
    printf "Overview of available playbooks:\n"
    printf "\t%s %s\n" "complete.yml      - deploys everything"
    printf "\t%s %s\n" "configuration.yml - deploys the configuration (nginx, uwsgi etc.)"
    printf "\t%s %s\n" "django.yml        - deploys the master and develop branches"
    printf "\t%s %s\n" "master.yml        - deploys the master branch"
    printf "\t%s %s\n" "develop.yml       - deploys the develop branch"
    exit 1
fi

ansible-playbook -i inventory $1
