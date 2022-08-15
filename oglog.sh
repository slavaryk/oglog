#! bin/bash

GIT_LOG_ALIAS=();
GIT_LOG_ALIAS_PIECE="";

function start_oglog() {
    local MENU_CHOISE="";
    local EXIT=3;

    while [ "$MENU_CHOISE" != "$EXIT" ];
        do
            show_main_menu;
            read -p $'\nTell me what you want\n' MENU_CHOISE;
            handle_main_menu_choice $MENU_CHOISE;
        done
}

function show_main_menu() {
    echo $'\nChoose your hero!\n';
    echo $'1. Add new git log alias';
    echo $'2. Take a hug!';
    echo $'3. Exit';
}

function handle_main_menu_choice() {
    local ALIAS_ADDING=1;
    local HUG=2;
    local EXIT=3;

    case $1 in
    $ALIAS_ADDING)
        build_git_log_alias;
        ;;
    $HUG)
        echo $'\nI HUG YOU <3!\n';
        ;;
    $EXIT)
        echo $'\nGood bye!\n'
    esac
}

function build_git_log_alias() {
    local MENU_CHOISE="";
    local EXIT=13;

    while [ "$MENU_CHOISE" != "$EXIT" ];
        do
            show_pieces_menu;
            read -p $'
                \nWhat you want to see in your git log!\n
            ' MENU_CHOISE;
            handle_piece_choice $MENU_CHOISE;
        done
}

function show_pieces_menu() {
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
    echo $'13. Back';
}

function handle_piece_choice() {
    local COMMIT_HASH=("1" "%h");
    local TREE_HASH=("2" "%t");
    local PARENT_HASH=("3" "%p");
    local AUTHOR_NAME=("4" "%an");
    local AUTHOR_EMAIL=("5" "%ae");
    local AUTHOR_DATE=("6" "%ad");
    local AUTHOR_RELATIVE_DATE=("7" "%ar");
    local COMMITER_NAME=("8" "%cn");
    local COMMITER_EMAIL=("9" "%ce");
    local COMMITER_DATE=("10" "%cd");
    local COMMITER_RELATIVE_DATE=("11" "%cr");
    local MESSAGE=("12" "%s");

    case $1 in
    ${COMMIT_HASH[0]})
        GIT_LOG_ALIAS_PIECE+="${COMMIT_HASH[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${TREE_HASH[0]})
        GIT_LOG_ALIAS_PIECE+="${TREE_HASH[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${PARENT_HASH[0]})
        GIT_LOG_ALIAS_PIECE+="${PARENT_HASH[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${AUTHOR_NAME[0]})
        GIT_LOG_ALIAS_PIECE+="${AUTHOR_NAME[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${AUTHOR_EMAIL[0]})
        GIT_LOG_ALIAS_PIECE+="${AUTHOR_EMAIL[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${AUTHOR_DATE[0]})
        GIT_LOG_ALIAS_PIECE+="${AUTHOR_DATE[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${AUTHOR_RELATIVE_DATE[0]})
        GIT_LOG_ALIAS_PIECE+="${AUTHOR_RELATIVE_DATE[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${COMMITER_NAME[0]})
        GIT_LOG_ALIAS_PIECE+="${COMMITER_NAME[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${COMMITER_EMAIL[0]})
        GIT_LOG_ALIAS_PIECE+="${COMMITER_EMAIL[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${COMMITER_DATE[0]})
        GIT_LOG_ALIAS_PIECE+="${COMMITER_DATE[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${COMMITER_RELATIVE_DATE[0]})
        GIT_LOG_ALIAS_PIECE+="${COMMITER_RELATIVE_DATE[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    ${MESSAGE[0]})
        GIT_LOG_ALIAS_PIECE+="${MESSAGE[1]}";
        echo "$GIT_LOG_ALIAS_PIECE";
        ;;
    esac
}

start_oglog;

unset GIT_LOG_ALIAS;
unset GIT_LOG_ALIAS_PIECE;