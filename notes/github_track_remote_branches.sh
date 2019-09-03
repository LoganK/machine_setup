#!/bin/bash

set -e

# Cross-update all branches from one repository into another.

UPSTREAM=$1
MYREPO=$2

usage() {
   echo "Usage:"
   echo "$0 <upstream-remote> <target-remote>"
   exit 1
}

if [ -z "$UPSTREAM" ]
then
 echo Missing upstream remote name.
 usage
fi

if [ -z "$MYREPO" ]
then
 echo Missing target remote name. 
 usage
fi

git fetch $UPSTREAM

for br in $(git branch -r | grep "$UPSTREAM/" | sed -e 's|[^/]*/||'); do
  git push -u ${MYREPO} refs/remotes/${UPSTREAM}/${br}:refs/heads/${br}
done

