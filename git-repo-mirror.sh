#!/bin/bash

set -e

# first set up ssh
eval `ssh-agent`
ssh-add ~/.ssh/bitbucket_repo-pusher_rsa

# first pull only master from private
cd /opt/git-repo-mirror/barerepo
git fetch --tags private master:master

# now push only master to public
git push --tags public master
