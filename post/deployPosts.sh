#!/bin/sh

# move post/before/* to _posts/
mv post/before/* _posts/

# Git 명령어 추가
git add .

git commit -m "upload with deployPosts.sh"

git push

echo "[Success] : Changes have been pushed to the repository!"