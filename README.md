Goal
---

Take one repository called `privaterepo` and mirror the `master` branch in a separate repository called `publicrepo`.

How It Works
---

A pusher called `repo-pusher` is created.  `repo-pusher` is given read access to `privaterepo` and write access to `publicrepo`.  A user is created since bitbucket manages write access through users; deployment keys are read-only.

On some server, call it `localserver` a cron script is used to run `mirror.sh`.  `git-repo-mirror` uses an ssh key generated and registered with `repo-pusher` to fetch updates from `privaterepo` and to push to `public repo`.

Installation Steps
---

1. on the local server, git clone this repository to somewhere special:
```
sudo git clone git@github.com:lukeolson/git-repo-mirror.git /opt/git-repo-mirror
```
