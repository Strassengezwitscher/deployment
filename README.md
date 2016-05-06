# Strassengezwitscher Deployment

## What is this?
Use this ansible-based repository to deploy stuff to the Strassengezwitscher server. This includes:

- The master and/or develop branch of the Strassengezwitscher Django app.
- The configuration for nginx and uwsgi.
- The preparation for automatic deployment by Travis.

## Limitations
This does not configure the whole server. There are some things you need to do manually first:

- Setup and harden your SSH and setup public key authentication.
- Create a user `deploy` as these scripts will act in its name.
- Add the `deploy` user to the `sudoers` file.

Moreover, this setup targets Ubuntu 16.04 LTS.

## Preparation
For the deployment to our server to work you need some sensitive data which is not part of this repository. You will need to create the file `group_vars/sensitive.yml` with the correct values for the dummy keys from `group_vars/all`.

## Running the deployment
Just run `deploy.sh` and let it know which parts you want to deploy. You can choose from:

- complete.yml - deploys everything
- configuration.yml - deploys the configuration (nginx, uwsgi etc.)
- django.yml - deploys the master and develop branches
- master.yml - deploys the master branch
- develop.yml - deploys the develop branch

Example:
`
./deploy.sh master.yml
`
