#!/bin/bash

git fetch --all
git pull --all
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git push github --mirror

git clone --mirror git@github.com:adeo/opp--$1.git

java -jar /home/irisha/Downloads/bfg.jar --replace-text /home/irisha/Projects/deploy/kubernetes/password.txt opp--$1.git/

echo cd opp--$1.git/

cd opp--$1.git/

echo git reflog...

git reflog expire --expire=now --all && git gc --prune=now --aggressive

echo git push...

git push

echo COMPLETED!
