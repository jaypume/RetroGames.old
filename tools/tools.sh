
IFS=$'\n'      # Change IFS to newline char
names=(
"rom/Arcade/1999 - MAME/MAME"
"rom/Arcade/1996 - CPS3/Capcom - CPS3"
"rom/Arcade/1993 - CPS2/Capcom - CPS2"
"rom/Arcade/1988 - CPS1/Capcom - CPS1"
"rom/Classic/1999 - WS/BAIDAI - WS"
"rom/Classic/1998 - NGP/SNK - NGP"
"rom/Classic/1994 - PC-FX/NEC - PC-FX"
"rom/Classic/1993 - 3DO/The 3DO Company - 3DO"
"rom/Classic/1991 - NEOGEO/SNK - Neo Geo"
"rom/Classic/1989 - LYNX/Atari - Lynx"
"rom/Classic/1988 - PCE CD/NEC - PCE CD"
"rom/Classic/1987 - PCE/NEC - PCE"
"rom/Microsoft/1995 - DOS/Microsoft - DOS"
"rom/Nintendo/2011 - 3DS/Nintendo - 3DS"
"rom/Nintendo/2006 - WII/Nintendo - WII"
"rom/Nintendo/2004 - NDS/Nintendo - NDS"
"rom/Nintendo/2001 - NGC/Nintendo - NGC"
"rom/Nintendo/2001 - GBA/Nintendo - GBA ALL"
"rom/Nintendo/2001 - GBA/Nintendo - GBA"
"rom/Nintendo/1998 - GBC/Nintendo - GBC"
"rom/Nintendo/1996 - N64/Nintendo - N64 ALL"
"rom/Nintendo/1996 - N64/Nintendo - N64"
"rom/Nintendo/1998 - GBC/Nintendo - GBC ALL"
"rom/Nintendo/1990 - SFC/Nintendo - SFC ALL"
"rom/Nintendo/1990 - SFC/Nintendo - SFC"
"rom/Nintendo/1989 - GB/Nintendo - GB ALL"
"rom/Nintendo/1983 - FC/Nintendo - FC ALL"
"rom/Nintendo/1983 - FC/Nintendo - FC"
"rom/Sega/1986 - MS/Sega - MS"
"rom/Sega/1988 - MD/Sega - MD"
"rom/Sega/1990 - GG/Sega - GG"
"rom/Sega/1994 - Sega 32X/Sega - 32X"
"rom/Sega/1994 - SS/Sega - Saturn"
"rom/Sega/1998 - DC/Sega - Dreamcast"
"rom/Sony/2004 - PSP/Sony - PSP"
"rom/Sony/2000 - PS2/Sony - PS2"
"rom/Sony/1994 - PS1/Sony - PS1"
) 



# update emulators/RetroArch/_all_/RetroArch
# should be call in the right directory

update_retroarch_rom_relative_path() {
    # cd ../emulators/RetroArch/_all_/RetroArch/@ROM/
    root_path=`git rev-parse --show-toplevel`
    for elem in ${names[@]};
    do
        dir_name=`basename $elem`
        ln -rs $root_path/$elem $dir_name
    done
}


# update_retroarch_rom_relative_path