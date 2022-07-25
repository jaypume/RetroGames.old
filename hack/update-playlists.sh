#!/bin/bash

# This is the source root /path/to/RetroGames/
ROOT_PATH=$(git rev-parse --show-toplevel)

platforms=(
    # platform, default_path_prefix
    'Android', ''
    'Apple IOS'
    'Nintendo Switch'
    'Sony PSV'
    'Windows'
)

emulators=(
    '3DO - 3DO'
    'Atari - Lynx'
    'BANDAI - WS'
    'Capcom - CPS1'
    'Capcom - CPS2'
    'Capcom - CPS3'
    'MAME'
    'Microsoft - DOS'
    'NEC - PC-FX'
    'NEC - PCE'
    'NEC - PCE CD'
    'Nintendo - 3DS'
    'Nintendo - FC'
    'Nintendo - FC ALL'
    'Nintendo - GB ALL'
    'Nintendo - GBA'
    'Nintendo - GBA ALL'
    'Nintendo - GBC'
    'Nintendo - GBC ALL'
    'Nintendo - N64'
    'Nintendo - N64 ALL'
    'Nintendo - NDS'
    'Nintendo - NGC'
    'Nintendo - SFC'
    'Nintendo - SFC ALL'
    'Nintendo - WII'
    'Sega - 32X'
    'Sega - Dreamcast'
    'Sega - GG'
    'Sega - MD'
    'Sega - MS'
    'Sega - Naomi'
    'Sega - Saturn'
    'SNK - NeoGeo'
    'SNK - NGP'
    'Sony - PS1'
    'Sony - PS2'
    'Sony - PSP'
)

update_sorted_csv() {
    titles=""
    for f in "$_dir_rom"/*; do
        file=$(basename "$f")
        title=$(basename -s $suffix "$file")
        # TODO: 在-或者·前面添加空格，如果前面不是中文的话
        # TODO: 如果后缀不满足，应该给出warning
        echo "$file"
        # TODO: 换用更快速的go-pinyin版本
        title_py=$(echo $(pypinyin -s zhao "$title") | awk '{$1=$1};1')
        titles+="$title, $title_py"$'\n'
    done
    echo "$titles" >"$csv_file".unsort.csv
    sorted="$(sort -k 2 -t ',' "$csv_file".unsort.csv)"
    echo "$sorted" >"$csv_file.csv"
}

update_playlists_from_csv() {
    # A line in csv file is like:
    # 龙珠大冒险, long zhu da mao xian
    lines=""
    while IFS=',' read -r cn_name py_name; do
        echo "$cn_name"
        lines+=$(jq -n -c --arg path "$prefix$cn_name$suffix" \
            --arg label "$cn_name" \
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

update_platform_emulator() {
    platform=$1 # For example: Android, Apple IOS
    emulator=$2 # For example: Nintendo - GBA
    suffix=$3
    prefix=$4
    _dir=$ROOT_PATH/emulators/RetroArch/$platform/RetroArch.Full
    _dir_rom=$_dir/@ROM/$emulator
    _dir_csv=$_dir/csv
    _dir_lpl=$_dir/playlists
    csv_file=$_dir_csv/$emulator
    mkdir -p "$_dir_csv"
    mkdir -p "$_dir_lpl"

    # update_sorted_csv
    update_playlists_from_csv
}

update_platform_emulator "Android" "Nintendo - GBA" ".gba" "/storage/XXXX-XXXX/RetroArch/@ROM/Nintendo - GBA/"
# update_platform_emulator "Android" "Sony - PS2" ".chd"
