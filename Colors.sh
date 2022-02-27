`Coloring Style Text Using Shell Scripting – Color Codes Table
Color          Background Foreground
Red            41             31
Black          40             30
Green          42             32
Blue           44             34
Yellow         43             33
Magenta        45             35
Cyan           46             36
white          47             37
`
`Changing text Style in shell script
Style          Number
Plain           0
Bold            1
Low Intensity   2
Underline       4
Blinking        5
Reverse         7
Invisible       8
`

#!/bin/bash
#
#   This file echoes a bunch of color codes to the 
#   terminal to demonstrate what's available.  Each 
#   line is the color code of one forground color,
#   out of 17 (default + 16 escapes), followed by a 
#   test use of that color on all nine background 
#   colors (default + 8 escapes).
#

T='gYw'   # The test text

echo -e "\n                 40m     41m     42m     43m\
     44m     45m     46m     47m";

for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
           '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
           '  36m' '1;36m' '  37m' '1;37m';
  do FG=${FGs// /}
  echo -en " $FGs \033[$FG  $T  "
  for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
    do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
  done
  echo;
done
echo

#---------------------------------------------colours-script-2-----------------------------------------------------

#!/bin/bash
#
# ANSI color scheme script featuring Space Invaders
#
# Original: http://crunchbanglinux.org/forums/post/126921/#p126921
# Modified by lolilolicon
#

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'

cat << EOF

 $f1  ▀▄   ▄▀     $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4  ▀▄   ▄▀     $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst
 $f1 ▄█▀███▀█▄    $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4 ▄█▀███▀█▄    $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst
 $f1█▀███████▀█   $f2▀▀███▀▀███▀▀   $f3▀█▀██▀█▀   $f4█▀███████▀█   $f5▀▀███▀▀███▀▀   $f6▀█▀██▀█▀$rst
 $f1▀ ▀▄▄ ▄▄▀ ▀   $f2 ▀█▄ ▀▀ ▄█▀    $f3▀▄    ▄▀   $f4▀ ▀▄▄ ▄▄▀ ▀   $f5 ▀█▄ ▀▀ ▄█▀    $f6▀▄    ▄▀$rst

 $bld$f1▄ ▀▄   ▄▀ ▄   $f2 ▄▄▄████▄▄▄    $f3  ▄██▄     $f4▄ ▀▄   ▄▀ ▄   $f5 ▄▄▄████▄▄▄    $f6  ▄██▄  $rst
 $bld$f1█▄█▀███▀█▄█   $f2███▀▀██▀▀███   $f3▄█▀██▀█▄   $f4█▄█▀███▀█▄█   $f5███▀▀██▀▀███   $f6▄█▀██▀█▄$rst
 $bld$f1▀█████████▀   $f2▀▀▀██▀▀██▀▀▀   $f3▀▀█▀▀█▀▀   $f4▀█████████▀   $f5▀▀▀██▀▀██▀▀▀   $f6▀▀█▀▀█▀▀$rst
 $bld$f1 ▄▀     ▀▄    $f2▄▄▀▀ ▀▀ ▀▀▄▄   $f3▄▀▄▀▀▄▀▄   $f4 ▄▀     ▀▄    $f5▄▄▀▀ ▀▀ ▀▀▄▄   $f6▄▀▄▀▀▄▀▄$rst


                                     $f7▌$rst

                                   $f7▌$rst

                              $f7    ▄█▄    $rst
                              $f7▄█████████▄$rst
                              $f7▀▀▀▀▀▀▀▀▀▀▀$rst

EOF

#--------------------------------------Colors-script-3----------------------------------------------------------
#!/bin/bash
echo -e "\n\033[4;31mLight Colors\033[0m \t\t\t  \033[1;4;31mDark Colors\033[0m"
echo -e " \e[0;30;47m Black     \e[0m   0;30m \t\t \e[1;30;40m Dark Gray   \e[0m  1;30m"
echo -e " \e[0;31;47m Red       \e[0m   0;31m \t\t \e[1;31;40m Dark Red    \e[0m  1;31m"
echo -e " \e[0;32;47m Green     \e[0m   0;32m \t\t \e[1;32;40m Dark Green  \e[0m  1;32m"
echo -e " \e[0;33;47m Brown     \e[0m   0;33m \t\t \e[1;33;40m Yellow      \e[0m  1;33m"
echo -e " \e[0;34;47m Blue      \e[0m   0;34m \t\t \e[1;34;40m Dark Blue   \e[0m  1;34m"
echo -e " \e[0;35;47m Magenta   \e[0m   0;35m \t\t \e[1;35;40m Dark Magenta\e[0m  1;35m"
echo -e " \e[0;36;47m Cyan      \e[0m   0;36m \t\t \e[1;36;40m Dark Cyan   \e[0m  1;36m"
echo -e " \e[0;37;47m Light Gray\e[0m   0;37m \t\t \e[1;37;40m White       \e[0m  1;37m"

#---------------------------------------colours-script-4----------------------------------------------------------
#!/bin/bash

echo "tput colors test"
echo "================"
echo
echo "tput setaf/setab [0-9] ... tput sgr0"
echo

for fg_color in {0..7}; do
  set_foreground=$(tput setaf $fg_color)
  for bg_color in {0..7}; do
    set_background=$(tput setab $bg_color)
    echo -n $set_background$set_foreground
    printf ' F:%s B:%s ' $fg_color $bg_color
  done
  echo $(tput sgr0)
done

echo
echo "END"
echo
exit

#--------------------------------------------colours-script-5------------------------------------------------------------
#!/bin/bash
cat "$0" 1>&2;
#
# = Coloring test utility =
#
# [
# |*| Source: https://unix.stackexchange.com/a/643536
# |*| Source (original): https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# |*| Last update: CE 2021-05-13 15:22 UTC ]
#
#
# [ Caveat:
#
# The description below has insufficient coverage on the subject. (and part of which may be outright misleading)
#
# Check # References for a complete view. ]
#
#
# This script shall echo a bunch of color codes: demonstrating the coloring compatibility of the shell / terminal.
#
# Each output line of interest would consist of:
# |*| The literal color code itself: of 1 foreground (font) color, out of the 17 (default + 16 escapes).
# |*| Followed by its testcase: with all of the 9 background colors (default + 8 escapes).
#
#
#
#
# == Implementation ==
#
# Testcase text:
    text='gYw';

    echo -e '\n         [m     [40m    [41m    [42m    [43m    [44m    [45m    [46m    [47m';

    for FGs in \
    '  [0;m' \
    '[1;37m' \
    '[0;30m' \
    '[1;30m' \
    '[0;31m' \
    '[1;31m' \
    '[0;32m' \
    '[1;32m' \
    '[0;33m' \
    '[1;33m' \
    '[0;34m' \
    '[1;34m' \
    '[0;35m' \
    '[1;35m' \
    '[0;36m' \
    '[1;36m' \
    '[0;37m';

    do {
    FG="${FGs//[[:space:]]/""}";
    echo -nE "$FGs ";
    echo -ne '\e'$FG;
    echo -nE "  $text  ";

    for BG in \
    '[40m' '[41m' '[42m' '[43m' '[44m' '[45m' '[46m' '[47m';

    do
    echo -nE ' ';
    echo -ne '\e'$FG'\e'$BG; # [Note 1]
    echo -nE "  $text  ";
    echo -ne '\e[m'; # [Note 2]

    done;

    echo;
    };

    done;

    unset text FGs FG BG;
    echo;
#
#
#
#
# == Notes & References ==
#
#
# === Notes ===
#
# [Note 1]
# [
# Note the order may not be inverted: setting the foreground color ("$FG") may reset the background color ("$BG").
#
# Check ANSI escape sequence # CSI [1], and [ https://misc.flogisoft.com/bash/tip_colors_and_formatting#attributes_combination ] [3] for details. ]
#
#
# [Note 2]
# [
# There are also some other formatting codes not included in the table but may be used to alter the text's appearance:
#
# |*| '\e[1m': Bold
# |*| '\e[2m': Dim
# |*| '\e[4m': Underlined
# |*| '\e[5m': Blink
# |*| '\e[7m': Inverse color
# |*| '\e[8m': Hidden
# |*| '\e[9m': Strikethrough ]
#
#
# === References ===
#
# [1]
# [
# |*| ANSI escape sequence ## CSI; SGR; Examples:
# [
# |*| https://en.wikipedia.org/wiki/ANSI_escape_code#CSI
# |*| https://en.wikipedia.org/wiki/ANSI_escape_code#SGR
# |*| https://en.wikipedia.org/wiki/ANSI_escape_code#Examples ] ]
#
#
# [2]
# [
# |*| Unix formatting code (Google Search): https://www.google.com/search?hl=en&q=Unix+formatting%7Ccolor+code ]
#
#
# [3]
# [
# |*| Colors and formatting (ANSI/VT100 Control sequences): https://misc.flogisoft.com/bash/tip_colors_and_formatting ]
#
#
#
#
# == See also ==
#
# |*| 256-color test: https://unix.stackexchange.com/a/643715
#