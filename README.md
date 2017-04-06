Goal
---

Take one repository called `privaterepo` and mirror the `master` branch in a separate repository called `publicrepo`.

How It Works
---

A pusher called `repo-pusher` is created.  `repo-pusher` is given read access to `privaterepo` and write access to `publicrepo`.  A user is created since bitbucket manages write access through users; deployment keys are read-only.

On some server, call it `localserver` a cron script is used to run `mirror.sh`.  `git-repo-mirror` uses an ssh key generated and registered with `repo-pusher` to fetch updates from `privaterepo` and to push to `public repo`.

Installation Steps
---
1. Create a user, `repo-pusher`.  Give `repo-pusher` read access to `privaterepo` and write access to `publicrepo`.

1. On `localserver` create an ssh-key for `repo-pusher` with no passphrase:
```
sudo ssh-keygen -f /root/.ssh/bitbucket_repo-pusher_rsa -C "repo-pusher"
```
Add this public key to the `repo-pusher` on bitbucket.

1. On `localserver`, git clone this repository to somewhere special:
```
sudo git clone https://github.com/lukeolson/git-repo-mirror.git /opt/git-repo-mirror
```

1. On `localserver`, create an initialize a bare directory, adding `privaterepo` and `publicrepo` as remotes.  Then initilize the repo by fetching.
```
sudo -i
eval \`ssh-agent\`
ssh-add ~/.ssh/bitbucket_repo-pusher_rsa
cd /opt/git-repo-mirror
mkdir barerepo
cd barerepo
git init --bare
git remote add private git@bitbucket.org:xpacc-dev/plascomcm.git
git remote add public git@bitbucket.org:xpacc/plascomcm.git
git fetch private master:master
```

1. Now set up the cron job in `/etc/crontab`:
```
# *  *  *  *  * user-name command to be executed
  0  12 *  *  * root /opt/git-repo-mirror/git-repo-mirror.sh
```
