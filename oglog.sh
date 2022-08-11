#! bin/bash

GIT_LOG_ALIAS="JOOBA"

function show_menu() {
    echo $'\nChoose your hero!\n'
    echo $'1. Configure git log'
    echo $'2. Take a hug!'
    echo $'3. Exit'
}

while [ "$MENU_CHOISE" != 3 ];
    do
        show_menu;
        read -p $'\nTell me what you want\n' MENU_CHOISE;
    done

echo $'\nGood bye!'
unset MENU_CHOISE;
