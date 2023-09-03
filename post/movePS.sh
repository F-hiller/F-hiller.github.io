#!/bin/sh

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
    mv "$file" "post/before/$new_filename"
done

echo "[Success] : Files have been moved and updated!"