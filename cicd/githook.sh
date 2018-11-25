#!/bin/bash

while read oldrev newrev refname
do
  branch=$(git rev-parse --symbolic --abbrev-ref $refname)
  if [[ "$branch" == "master" ]]; then
    curl -k -X POST --user user7-admin:5427b4ddcafa4f6e0624b4e65006e20f https://jenkins-user7-jenkins.apps.4f28.openshift.opentlc.com/job/Tasks/build
  fi
done