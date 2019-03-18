#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied. Select a branch you will merge in test"
    exit 1
fi

if git push origin $1;
    then echo "push in $1 was successfully"
else
   exit 1
fi

echo 'git checkout testing'
git checkout testing

if git pull origin testing;
    then echo "pull was successfully"
else
    exit 1
fi

git submodule update
echo pull success

if git merge $1;
   then echo "merge was successfully"
else
    exit 1
fi

if git push origin testing;
    then echo "push in testing was successfully"
else
   exit 1
fi

git checkout $1
git submodule update
git status