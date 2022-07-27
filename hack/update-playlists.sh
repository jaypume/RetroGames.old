#!/bin/zsh
# TODO: may need to move zsh to bash

# This is the source root /path/to/RetroGames/
ROOT_PATH=$(git rev-parse --show-toplevel)

# Android: should replace XXXX-XXXX to your real SD card ID
# Windows: should replace '/' to '\\' global
# Switch: not supports Chinese filename, for making sure it works right,
# we need to `bash hack/update-switch-rom`
# should not have space after ',', this will cause some error
platforms=(
    # platform, default_path_prefix
    # 'Android,/storage/XXXX-XXXX/RetroArch/@ROM'
    # 'Apple IOS,~/Documents/RetroArch/@ROM'
    'Nintendo Switch,/retroarch/@ROM'
    # 'Sony PSV,uma0:/data/retroarch/@ROM'
    # 'Windows,D:\RetroArch\@ROM'
)

emulators=(
    # '3DO - 3DO'
    'Atari - Lynx'
    'BANDAI - WS'
    # 'Capcom - CPS1'
    # 'Capcom - CPS2'
    # 'Capcom - CPS3'
    # 'MAME'
    'Microsoft - DOS'
    # 'NEC - PC-FX'
    'NEC - PCE'
    # 'NEC - PCE CD'
    'Nintendo - 3DS'
    'Nintendo - FC'
    # 'Nintendo - FC ALL'
    # 'Nintendo - GB ALL'
    'Nintendo - GBA'
    # 'Nintendo - GBA ALL'
    'Nintendo - GBC'
    # 'Nintendo - GBC ALL'
    'Nintendo - N64'
    # 'Nintendo - N64 ALL'
    'Nintendo - NDS'
    'Nintendo - NGC'
    'Nintendo - SFC'
    # 'Nintendo - SFC ALL'
    'Nintendo - WII'
    'Sega - 32X'
    # 'Sega - Dreamcast'
    'Sega - GG'
    'Sega - MD'
    'Sega - MS'
    'Sega - Naomi'
    'Sega - Saturn'
    # 'SNK - NeoGeo'
    'SNK - NGP'
    'Sony - PS1'
    'Sony - PS2'
    'Sony - PSP'
)

update_sorted_csv() {
    lines=
    # _dir_rom: ".../@ROM/Nintendo - GBA"

    for f in "$_dir_rom"/*; do
        file=$(basename "$f")
        extension="${file##*.}"
        filename="${file%.*}"
        # TODO: 如果是文件夹该怎么处理
        echo "$file"
        # TODO: 换用更快速的go-pinyin版本
        #只把title转换为拼音
        if [[ $_dir_rom == *ALL ]]; then
            # if it is end with "ALL", it shows that all filenames are in Englinsh.
            file_py="$file"
        else
            # Chinese filename included, need to transfer to pinyin
            file_py=$(echo $(pypinyin -s zhao "$filename") | awk '{$1=$1};1').$extension
        fi
        # should no space here
        lines+="$file,$file_py"$'\n'
    done
    echo -n "$lines" >"$csv_file".unsort.csv
    sorted="$(sort -k 2 -t ',' "$csv_file".unsort.csv)"
    echo "$sorted" >"$csv_file.csv"
    rm -f "$csv_file".unsort.csv
}

update_playlists_from_csv() {
    # A line in csv file is like:
    # 龙珠大冒险.gba, long zhu da mao xian
    lines=""
    while IFS=',' read -r cn_name py_name; do
        echo "$cn_name"
        lines+=$(jq -n -c --arg path "$prefix/$emulator/$py_name" \
            --arg label "${cn_name%.*}" \
            --arg core_path "" \
            --arg core_name "" \
            --arg crc32 '00000000|crc' \
            --arg db_name "$emulator.lpl" \
            '$ARGS.named')
    done < <(tail -n +1 "$csv_file.csv")
    lines_json=$(jq -s '.' <<<$lines)

    # The final json in *.lpl playlists file.
    lpl_json=$(jq -n --arg version "1.2" \
        --arg default_core_path "" \
        --arg default_core_name "" \
        --arg label_display_mode 0 \
        --arg right_thumbnail_mode 1 \
        --arg left_thumbnail_mode 0 \
        --argjson items "$lines_json" \
        '$ARGS.named')

    # Then output it to for example xx/playlists/Nintendo - GBA.lpl
    echo "$lpl_json" >"$_dir_lpl/$emulator.lpl"
}

update_one_platform_one_emulator() {
    platform=$1 # For example: Android, Apple IOS
    emulator=$2 # For example: Nintendo - GBA
    prefix=$3
    _dir=$ROOT_PATH/emulators/RetroArch/$platform/RetroArch.Full
    _dir_rom=$_dir/@ROM/$emulator
    _dir_csv=$ROOT_PATH/emulators/RetroArch/_base_/RetroArch/CSV
    _dir_lpl=$_dir/playlists
    csv_file=$_dir_csv/$emulator
    mkdir -p "$_dir_csv"
    mkdir -p "$_dir_lpl"

    # if dont want to update all csv, comment this line
    # TODO: 优化这里的函数，如果已有csv的话，直接更新所有其他平台
    if [ -f "$csv_file".csv ]; then
        echo "$csv_file".csv" is existing, skip"
    else
        update_sorted_csv
    fi
    update_playlists_from_csv
}

update_all_platform_one_emulator() {
    for platform_and_prefix in "${platforms[@]}"; do
        platform=$(echo $platform_and_prefix | cut -d',' -f 1)
        prefix=$(echo $platform_and_prefix | cut -d',' -f 2)
        echo "=========================Starting to udpate ""[$platform : $emulator]"
        update_one_platform_one_emulator "$platform" "$emulator" "$prefix"
    done
}

update_all_platform_all_emulator() {
    for emulator in "${emulators[@]}"; do
        update_all_platform_one_emulator "$emulator"
    done
}

update_all_platform_all_emulator
