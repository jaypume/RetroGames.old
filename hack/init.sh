

# This is the source root /path/to/RetroGames/
ROOT_PATH=$(git rev-parse --show-toplevel)
BASE_RA_PATH="emulators/RetroArch/_base_/RetroArch"
BASE_NS_PATH="emulators/RetroArch/Nintendo Switch/RetroArch.Full"

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