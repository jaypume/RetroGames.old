#!/bin/bash

# This is the source root /path/to/RetroGames/
ROOT_PATH=$(git rev-parse --show-toplevel)
BASE_RA_PATH="emulators/RetroArch/_base_/RetroArch"
BASE_NS_PATH="emulators/RetroArch/Nintendo Switch/RetroArch.Full"



platform="Nintendo - GBA"

while IFS=, read cn_name py_name; do
    from="$ROOT_PATH/$BASE_NS_PATH/@ROM/$platform/$cn_name"
    to="$ROOT_PATH/$BASE_NS_PATH/@ROM/$platform/$py_name"
    mv -v "$from" "$to" ;
done < "$ROOT_PATH/$BASE_RA_PATH/CSV/$platform.csv"
