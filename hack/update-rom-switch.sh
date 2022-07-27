#!/bin/bash



bash init.sh

update_one_emulator() {
    echo "start to update $emulator"
    # while IFS=, read cn_name py_name; do
    #     from="$ROOT_PATH/$BASE_NS_PATH/@ROM/$emulator/$cn_name"
    #     to="$ROOT_PATH/$BASE_NS_PATH/@ROM/$emulator/$py_name"
    #     mv -v "$from" "$to"
    # done <"$ROOT_PATH/$BASE_RA_PATH/CSV/$emulator.csv"

    if [[ -d "$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Snaps" ]]; then
        while IFS=, read cn_name py_name; do
            cn_name="${cn_name%.*}".png
            py_name="${py_name%.*}".png
            from="$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Snaps/$cn_name"
            to="$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Snaps/$py_name"
            mv -v "$from" "$to"
        done <"$ROOT_PATH/$BASE_RA_PATH/CSV/$emulator.csv"
    fi

    if [[ -d "$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Boxarts" ]]; then
        while IFS=, read cn_name py_name; do
            cn_name="${cn_name%.*}".png
            py_name="${py_name%.*}".png
            from="$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Boxarts/$cn_name"
            to="$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Boxarts/$py_name"
            mv -v "$from" "$to"
        done <"$ROOT_PATH/$BASE_RA_PATH/CSV/$emulator.csv"
    fi

    if [[ -d "$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Titles" ]]; then
        while IFS=, read cn_name py_name; do
            cn_name="${cn_name%.*}".png
            py_name="${py_name%.*}".png
            from="$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Titles/$cn_name"
            to="$ROOT_PATH/$BASE_NS_PATH/thumbnails/$emulator/Named_Titles/$py_name"
            mv -v "$from" "$to"
        done <"$ROOT_PATH/$BASE_RA_PATH/CSV/$emulator.csv"
    fi
}

update_all_emulator() {
    for emulator in "${emulators[@]}"; do
        update_one_emulator "$emulator"
    done
}

update_all_emulator
