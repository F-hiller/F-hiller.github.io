#!/bin/sh

# move post/before/* to _posts/
mv post/before/* _posts/

# Git 명령어 추가
git add .

git commit -m "upload with deployPosts.sh"

git push

echo -e "\033[31m[Success] : Changes have been pushed to the repository!\033[0m"