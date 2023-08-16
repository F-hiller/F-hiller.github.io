#!/bin/sh

# 파일의 수를 세기 위한 변수 초기화
file_count=0
single_file_name=""

for file in post/posts/*.md; do
    # code_numbers와 language 추출
    code=$(grep -E "^code_numbers:" "$file" | cut -d ' ' -f2)
    lang=$(grep -E "^language:" "$file" | cut -d ' ' -f2)
    current_title=$(grep -E "^title:" "$file" | cut -d ':' -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    date_val=$(grep -E "^date:" "$file" | cut -d ' ' -f2)

    code_num=$(echo $code | cut -d'-' -f2)
    code_name=$(echo $code | cut -d'-' -f1)
    
    new_title="\"[$code_name] $current_title - $code_num ($lang)\""
    new_filename="${date_val}-[${code_name}]$code_num.md"

    # macOS와 리눅스를 모두 지원하기 위해 OS를 확인
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS일 경우
        sed -i '' "/code_numbers:/d" "$file"
        sed -i '' "/language:/d" "$file"
        sed -i '' "s/^title: .*/title: $new_title/" "$file"
    else
        # 리눅스일 경우
        sed -i "/code_numbers:/d" "$file"
        sed -i "/language:/d" "$file"
        sed -i "s/^title: .*/title: $new_title/" "$file"
    fi

    # _posts 디렉터리로 파일 이동
    mv "$file" "_posts/$new_filename"

    # 파일 수 업데이트 및 파일 이름 저장
    file_count=$((file_count+1))
    single_file_name="$new_filename"
done

echo "[Success] : Files have been moved and updated!"

# Git 명령어 추가
git add .

# Commit message 결정
if [ $file_count -eq 1 ]; then
    git commit -m "upload $single_file_name"
else
    git commit -m "upload several files..."
fi

git push

echo "[Success] : Changes have been pushed to the repository!"