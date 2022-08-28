#! bin/bash

echo $'\nThis script will add a few lines to your .bashrc or .zshrc/\nIs this ok for you? Y/n/\n';

if [[ $0 == "-zsh" ]]
then
    while [[ "$user_answer" != "Y" && "$user_answer" != "y" && "$user_answer" != "N" && "$user_answer" != "n" ]]
        do
            read "user_answer?";
        done
else
    while [[ "$user_answer" != "Y" && "$user_answer" != "y" && "$user_answer" != "N" && "$user_answer" != "n" ]]
        do
            read user_answer;
        done
fi

case $user_answer in
"Y" | "y")
    echo "yes";
    ;;
"N" | "n")
    echo "noe";
    ;;
esac

unset user_answer;
