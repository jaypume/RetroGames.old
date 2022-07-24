#!/bin/zsh

# the command should like:
# ./gen_playlist.sh "Nintendo - GBA"

# db = "Nintendo - GBA"
db=$1

out=""
while read line; do
    cat >> out.txt << EOF
{
"path": "/storage/9C33-6BBD/RetroArch.Test/@ROM/Nintendo - GBA/$line.gba",
"label": "$line",
"core_path": "DETECT",
"core_name": "DETECT",
"crc32": "00000000|crc",
"db_name": "Nintendo - GBA.lpl"
},
EOF
done < $db.txt
