#!/bin/bash
git add .
read -p "Enter git commit message " GITMSG
git commit -m "$GITMSG"
git push origin master


