#! bin/bash

GIT_LOG_ALIAS="";
GIT_LOG_ALIAS_VALUE="";
GIT_LOG_ALIAS_PIECE="";

function oglog() {
    local MENU_CHOICE="";
    local EXIT="q";

    while [ "$MENU_CHOICE" != "$EXIT" ];
        do
            __oglog_show_main_menu;
            MENU_CHOICE=$(__oglog_read_user_input);
            __oglog_handle_main_menu_choice $MENU_CHOICE;
        done

    unset GIT_LOG_ALIAS;
    unset GIT_LOG_ALIAS_VALUE;
    unset GIT_LOG_ALIAS_PIECE;
    unset ALIAS_NAME;
    unset MENU_CHOICE;
}

function __oglog_read_user_input() {
    read user_input;
    echo "$user_input";
}

function __oglog_print_divider() {
    echo $'\n-----------------------\n';
}

function __oglog_show_main_menu() {
    echo $'\_/_/_/_/ Choose an option and hit enter: \_/_/_/_/';
    __oglog_print_divider;
    echo $'1. Add new git log alias';
    echo $'2. Take a hug!';
    echo $'3. Update';
    echo $'q. Exit';
    echo $'\nTell me what you want, what you realy realy want?\n';
}

function __oglog_handle_main_menu_choice() {
    local ALIAS_ADDING=1;
    local HUG=2;
    local UPDATE=3;
    local EXIT="q";

    case $1 in
    $ALIAS_ADDING)
        __oglog_build_git_log_alias;
        ;;
    $HUG)
        echo $'\nI HUG YOU <3!\n';
        ;;
    $UPDATE)
        eval "$(curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/update.sh")" && __oglog_update;
        ;;
    $EXIT)
        echo $'\nGood bye!\n'
        ;;
    *)
        echo $'\nHmmmph\n'
    esac
}

function __oglog_build_git_log_alias() {
    local MENU_CHOICE="";

    while [ "$MENU_CHOICE" != "s" ] && [ "$MENU_CHOICE" != "S" ];
        do
            __oglog_show_pieces_menu;
            MENU_CHOICE=$(__oglog_read_user_input);
            __oglog_handle_piece_choice $MENU_CHOICE;
        done

    echo $'\nName your alias!\n';
    GIT_LOG_ALIAS="git log --pretty=format:\"$GIT_LOG_ALIAS_VALUE\"";
    alias "$(__oglog_add_alias_name)=$GIT_LOG_ALIAS";
}

function __oglog_show_pieces_menu() {
    local WHITE="\033[01;37m";
    local RESTORE="\033[0m";

    echo $'\nWhat you want to see in your git log?';
    __oglog_print_divider;
    echo -e "$WHITE Commits: $RESTORE";
    echo $'1. Commit hash';
    echo $'2. Tree hash';
    echo $'3. Parent hashes\n';

    echo -e "$WHITE Author/Commiter info: $RESTORE";
    echo $'4. Author name';
    echo $'5. Author email';
    echo $'6. Author date';
    echo $'7. Relative author date';
    echo $'8. Commiter name';
    echo $'9. Commiter email';
    echo $'10. Commiter date';
    echo $'11. Relative commiter date\n';

    echo -e "$WHITE Commit information from author: $RESTORE";
    echo $'12. Message';
    echo $'13. Body (description)';
    echo $'14. Body and message';
    echo $'15. Notes\n';

    echo -e "$WHITE Refs: $RESTORE";
    echo $'16. Ref names (tags, branches) like --decorate option';
    echo $'17. Ref names, but without "(", ")"';
    echo $'\ns/S -> Save';
}

function __oglog_handle_piece_choice() {
    case $1 in
    "1")
        __oglog_build_alias_piece "%h";
        ;;
    "2")
        __oglog_build_alias_piece "%t";
        ;;
    "3")
        __oglog_build_alias_piece "%p";
        ;;
    "4")
        __oglog_build_alias_piece "%an";
        ;;
    "5")
        __oglog_build_alias_piece "%ae";
        ;;
    "6")
        __oglog_build_alias_piece "%ad";
        ;;
    "7")
        __oglog_build_alias_piece "%ar";
        ;;
    "8")
        __oglog_build_alias_piece "%cn";
        ;;
    "9")
        __oglog_build_alias_piece "%ce";
        ;;
    "10")
        __oglog_build_alias_piece "%cd";
        ;;
    "11")
        __oglog_build_alias_piece "%cr";
        ;;
    "12")
        __oglog_build_alias_piece "%s";
        ;;
    "13")
        __oglog_build_alias_piece "%b";
        ;;
    "14")
        __oglog_build_alias_piece "%B";
        ;;
    "15")
        __oglog_build_alias_piece "%N";
        ;;
    "16")
        __oglog_build_alias_piece "%d";
        ;;
    "17")
        __oglog_build_alias_piece "%D";
        ;;
    "s" | "S")
        echo $'Okay!';
        ;;
    *)
        echo $'\nMaybe try again?\n';
        ;;
    esac
}

function __oglog_build_alias_piece() {
    __oglog_show_color_menu;
    GIT_LOG_ALIAS_PIECE="$(__oglog_add_color_to_piece)$1";

    __oglog_show_dividers_menu;
    GIT_LOG_ALIAS_PIECE="$GIT_LOG_ALIAS_PIECE$(__oglog_add_divider_to_piece)";

    GIT_LOG_ALIAS_VALUE+="$GIT_LOG_ALIAS_PIECE";
    GIT_LOG_ALIAS_PIECE="";
    echo "$GIT_LOG_ALIAS_VALUE";
}

function __oglog_show_color_menu() {
    local RESTORE="\033[0m";
    local RED="\033[00;31m";
    local GREEN="\033[00;32m";
    local YELLOW="\033[00;33m";
    local BLUE="\033[00;34m";
    local CYAN="\033[00;36m";
    local MAGENTA="\033[00;35m";
    local WHITE="\033[01;37m";

    echo $'\nWhat color?'
    __oglog_print_divider;
    echo -e "1. $RED RED$RESTORE";
    echo -e "2. $GREEN GREEN$RESTORE";
    echo -e "3. $YELLOW YELLOW$RESTORE";
    echo -e "4. $BLUE BLUE$RESTORE";
    echo -e "5. $CYAN CYAN$RESTORE";
    echo -e "6. $MAGENTA MAGENTA$RESTORE";
    echo -e "7. $WHITE WHITE$RESTORE";
    echo -e "$RESTORE"
}

function __oglog_add_color_to_piece() {
    MENU_CHOICE="$(__oglog_read_user_input)";

    case $MENU_CHOICE in
    "1")
        echo "%C(red)";
        ;;
    "2")
        echo "%C(green)";
        ;;
    "3")
        echo "%C(yellow)";
        ;;
    "4")
        echo "%C(blue)";
        ;;
    "5")
        echo "%C(cyan)";
        ;;
    "6")
        echo "%C(magenta)";
        ;;
    "7")
        echo "%C(white)";
        ;;
    *)
        echo $'I don\'t know this color :(';
        ;;
    esac
}

function __oglog_show_dividers_menu() {
    echo $'\nWhat divider?\n';
    echo $'You can write your variant!\n';
    echo "1. --";
    echo "2. ->";
    echo "3. _";
    echo "4. :";
    echo "5. whitespace";
    echo "6. newline";
    echo "7. none";
}

function __oglog_add_divider_to_piece() {
    MENU_CHOICE="$(__oglog_read_user_input)";

    case $MENU_CHOICE in
    "1")
        echo $' -- ';
        ;;
    "2")
        echo $' -> ';
        ;;
    "3")
        echo $' _ ';
        ;;
    "4")
        echo $' : ';
        ;;
    "5")
        echo $' ';
        ;;
    "6")
        echo "%n";
        ;;
    "7")
        echo "";
        ;;
    *)
        echo "$MENU_CHOICE";
        ;;
    esac
}

function __oglog_show_options_menu() {
    local WHITE="\033[01;37m";
    local RESTORE="\033[0m";

    echo -e "$WHITE Other options: $RESTORE";
    echo $'1. Graph view (with * and lines)';
    echo $'2. No merge commits';
    echo $'3. Only merge commits';
    echo $'4. First-Parent view (gives a better way to look at evolution of topic branches)';
}

function __oglog_add_alias_name() {
    ALIAS_NAME=$(__oglog_read_user_input);
    echo "$ALIAS_NAME";
}
