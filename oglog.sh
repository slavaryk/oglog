#! bin/bash

GIT_LOG_ALIAS=();
GIT_LOG_ALIAS_PIECE="";

function show_main_menu() {
    echo $'\nChoose your hero!\n';
    echo $'1. Add new git log alias';
    echo $'2. Take a hug!';
    echo $'3. Exit';
}

function show_pieces_menu() {
    echo $'\nWhat you want to add to your git log!\n';
    echo $'1. Commit hash';
    echo $'2. Tree hash';
    echo $'3. Parent hash';
    echo $'4. Parent hash';
    echo $'5. Author name';
    echo $'6. Author email';
    echo $'7. Author email';
    echo $'8. Author date';
    echo $'9. Relative author date';
    echo $'10. Commiter name';
    echo $'11. Commiter email';
    echo $'12. Commiter date';
    echo $'13. Relative commiter date';
    echo $'14. Message';
    echo $'15. Back';
    echo $'16. Exit';
}

function show_colors_menu() {
    echo $'';
}

function show_divider_menu() {
    echo $'';
}

function handle_piece_choice() {
    echo $'';
}

while [ "$MENU_CHOISE" != 3 ];
    do
        case $MENU_CHOISE in
        1)
            unset MENU_CHOISE;
            while [ "$PIECE_MENU_CHOISE" != 15 ];
                do
                    show_pieces_menu;
                    read PIECE_MENU_CHOISE;
                done
            ;;
        2)
            unset MENU_CHOISE;
            echo "Take your hug <3"
            ;;
        3)
            unset MENU_CHOISE;
            exit
            ;;
        esac
        show_main_menu;
        read -p $'\nTell me what you want\n' MENU_CHOISE;
    done

echo $'\nGood bye!';
unset MENU_CHOISE;
