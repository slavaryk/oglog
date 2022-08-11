#! bin/bash

GIT_LOG_ALIAS="JOOBA";
GIT_LOG_ALIAS_PIECE="";

function show_main_menu() {
    echo $'\nChoose your hero!\n';
    echo $'1. Add new git log alias';
    echo $'2. Take a hug!';
    echo $'3. Exit';
}

function show_aliases_menu() {
    echo $'\nWhat you want to add to your git log!\n';
    echo $'1. Commit Hash (like 22e2792)';
}

while [ "$MENU_CHOISE" != 3 ];
    do
        if [[ "$MENU_CHOISE" == 1 ]]; then
            show_aliases_menu;
            read LOG_PIECE;
            echo "$LOG_PIECE";
        fi
        show_main_menu;
        read -p $'\nTell me what you want\n' MENU_CHOISE;
    done

echo $'\nGood bye!';
unset MENU_CHOISE;
