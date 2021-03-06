# Strassengezwitscher Deployment

## What is this?
Use this ansible-based repository to deploy stuff to the Strassengezwitscher server. This includes:

- The master and/or develop branch of the Strassengezwitscher Django app.
- The configuration for nginx and uwsgi.
- The preparation for automatic deployment by Travis.

## Limitations
This does not configure the whole server. There are some things you need to do manually first:

- Setup and harden your SSH and setup public key authentication.
- Create a user and a group `deploy` and add the user to the group as these scripts rely on both to exist.
- Add the `deploy` user to the `sudoers` file: `deploy ALL=(ALL) ALL`
- Make sure you have GnuPG installed (comes probably pre-installed)
- You need to manually create a file containg passwords etc., see below.

Moreover, this setup targets Ubuntu 16.04 LTS.

## Preparation
For the deployment to our server to work you need some sensitive data which is not part of this repository. You will need to create the file `group_vars/all/vault.yml` with the correct values for the dummy keys from `group_vars/all/all.yml`. You can/should encrypt it with ansible-vault.

## Running the deployment
Just run `deploy.sh` and let it know which parts you want to deploy. You can choose from:

- complete.yml - deploys everything
- tls_certificates.yml - installs TLS certificates
- configuration.yml - deploys the configuration (nginx, uwsgi etc.) (make sure you ran complete.yml or tls_certificates.yml before)
- django.yml - deploys the master and develop branches
- master.yml - deploys the master branch
- develop.yml - deploys the develop branch

Example:
`
./deploy.sh master.yml
`

### Manual steps
In production mode you will need to set some sensitive values such as email account credentials. Create a file named `sensitive_settings.py` in the `settings` directory and override the following settings (check `production.py` for their meanings and dummy values):

- SECRET_KEY
- ADMINS
- DEFAULT_FROM_EMAIL
- SERVER_EMAIL
- EMAIL_FROM_CONTACT
- EMAIL_TO_CONTACT_CONFIDENTIAL
- EMAIL_TO_CONTACT_NON_CONFIDENTIAL
- EMAIL_HOST
- EMAIL_HOST_USER
- EMAIL_HOST_PASSWORD

## Using this deployment for your own server

If you are not part of the Strassengezwitscher team and choose to deploy the [Strassengezwitscher Django app](https://github.com/Strassengezwitscher/Strassengezwitscher) to your own server, consider the following (besides adapting IPs etc.):

If you want Travis to deploy the code automatically, it needs to authenticate to your server, e.g. using public key authentication. However, you don't want a private key to be in a public repository. Fortunately, Travis can deal with encrypted data, so adding an encrypted private key to the repository is a viable option. For details check the [Travis documentation](https://docs.travis-ci.com/user/encrypting-files/).
