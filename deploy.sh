#!/bin/bash

set -ex

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not master."
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd assets

git init
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME
echo "https://${GH_TOKEN}:@github.com" > .git/credentials

git remote add upstream "https://$GH_TOKEN@github.com/akrulwich/software_engineering.git"
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git commit -m "Rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages
