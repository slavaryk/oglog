#! bin/bash

GIT_LOG_ALIAS="";
GIT_LOG_ALIAS_VALUE="";
GIT_LOG_ALIAS_PIECE="";

function oglog() {
    local MENU_CHOICE="";
    local EXIT="q";

    while [ "$MENU_CHOICE" != "$EXIT" ];
        do
            oglog_show_main_menu;
            MENU_CHOICE=$(oglog_read_user_input);
            oglog_handle_main_menu_choice $MENU_CHOICE;
        done
}

function oglog_read_user_input() {
    read user_input;
    echo "$user_input";
}

function oglog_show_main_menu() {
    echo $'\nChoose your hero!\n';
    echo $'1. Add new git log alias';
    echo $'2. Take a hug!';
    echo $'q. Exit';
    echo $'\nTell me what you want, what you realy realy want?\n';
}

function oglog_handle_main_menu_choice() {
    local ALIAS_ADDING=1;
    local HUG=2;
    local EXIT="q";

    case $1 in
    $ALIAS_ADDING)
        oglog_build_git_log_alias;
        ;;
    $HUG)
        echo $'\nI HUG YOU <3!\n';
        ;;
    $EXIT)
        echo $'\nGood bye!\n'
        ;;
    *)
        echo $'\nHmmmph\n'
    esac
}

function oglog_build_git_log_alias() {
    local MENU_CHOICE="";

    while [ "$MENU_CHOICE" != "s" ] && [ "$MENU_CHOICE" != "S" ];
        do
            oglog_show_pieces_menu;
            MENU_CHOICE=$(oglog_read_user_input);
            oglog_handle_piece_choice $MENU_CHOICE;
        done

    echo $'\nName your alias!\n';
    GIT_LOG_ALIAS="git log --pretty=format:\"$GIT_LOG_ALIAS_VALUE\"";
    alias "$(oglog_add_alias_name)=$GIT_LOG_ALIAS";
}

function oglog_show_pieces_menu() {
    echo $'\nWhat you want to see in your git log?\n';
    echo $'\n1. Commit hash';
    echo $'2. Tree hash';
    echo $'3. Parent hash';
    echo $'4. Author name';
    echo $'5. Author email';
    echo $'6. Author date';
    echo $'7. Relative author date';
    echo $'8. Commiter name';
    echo $'9. Commiter email';
    echo $'10. Commiter date';
    echo $'11. Relative commiter date';
    echo $'12. Message';
    echo $'\ns/S -> Save';
}

function oglog_handle_piece_choice() {
    case $1 in
    "1")
        oglog_build_alias_piece "%h";
        ;;
    "2")
        oglog_build_alias_piece "%t";
        ;;
    "3")
        oglog_build_alias_piece "%p";
        ;;
    "4")
        oglog_build_alias_piece "%an";
        ;;
    "5")
        oglog_build_alias_piece "%ae";
        ;;
    "6")
        oglog_build_alias_piece "%ad";
        ;;
    "7")
        oglog_build_alias_piece "%ar";
        ;;
    "8")
        oglog_build_alias_piece "%cn";
        ;;
    "9")
        oglog_build_alias_piece "%ce";
        ;;
    "10")
        oglog_build_alias_piece "%cd";
        ;;
    "11")
        oglog_build_alias_piece "%cr";
        ;;
    "12")
        oglog_build_alias_piece "%s";
        ;;
    "s" | "S")
        echo $'Okay!';
        ;;
    *)
        echo $'\nMaybe try again?\n';
        ;;
    esac
}

function oglog_build_alias_piece() {
    oglog_show_color_menu;
    GIT_LOG_ALIAS_PIECE="$(oglog_add_color_to_piece)$1";

    oglog_show_dividers_menu;
    GIT_LOG_ALIAS_PIECE="$GIT_LOG_ALIAS_PIECE$(oglog_add_divider_to_piece)";

    GIT_LOG_ALIAS_VALUE+="$GIT_LOG_ALIAS_PIECE";
    GIT_LOG_ALIAS_PIECE="";
    echo "$GIT_LOG_ALIAS_VALUE";
}

function oglog_show_color_menu() {
    local RESTORE="\033[0m";
    local RED=("\033[00;31m" "%C(red)");
    local GREEN=("\033[00;32m" "%C(green)");
    local YELLOW=("\033[00;33m" "%C(yellow)");
    local BLUE=("\033[00;34m" "%C(blue)");
    local CYAN=("\033[00;36m" "%C(cyan)");
    local MAGENTA=("\033[00;35m" "%C(magenta)");
    local WHITE=("\033[01;37m" "%C(white)");

    echo $'\nWhat color?\n'
    echo -e "1. ${RED[1]}RED${RESTORE}";
    echo -e "2. ${GREEN[1]}GREEN${RESTORE}";
    echo -e "3. ${YELLOW[1]}YELLOW${RESTORE}";
    echo -e "4. ${BLUE[1]}BLUE${RESTORE}";
    echo -e "5. ${CYAN[1]}CYAN${RESTORE}";
    echo -e "6. ${MAGENTA[1]}MAGENTA${RESTORE}";
    echo -e "7. ${WHITE[1]}WHITE${RESTORE}";
    echo -e "${RESTORE}"
}

function oglog_add_color_to_piece() {
    MENU_CHOICE="$(oglog_read_user_input)";

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

function oglog_show_dividers_menu() {
    echo $'\nWhat divider?\n';
    echo $'You can write your variant!\n';
    echo "1. --";
    echo "2. ->";
    echo "3. _";
    echo "4. :";
    echo "5. whitespace";
    echo "6. none";
}

function oglog_add_divider_to_piece() {
    MENU_CHOICE="$(oglog_read_user_input)";

    case $MENU_CHOICE in
    "1")
        echo $'--';
        ;;
    "2")
        echo $'->';
        ;;
    "3")
        echo $'_';
        ;;
    "4")
        echo $':';
        ;;
    "5")
        echo $' ';
        ;;
    "6")
        echo "";
        ;;
    *)
        echo "$MENU_CHOICE";
        ;;
    esac
}

function oglog_add_alias_name() {
    ALIAS_NAME=$(oglog_read_user_input);
    echo "$ALIAS_NAME";
}

unset GIT_LOG_ALIAS;
unset GIT_LOG_ALIAS_VALUE;
unset GIT_LOG_ALIAS_PIECE;
unset ALIAS_NAME;
unset MENU_CHOICE;
