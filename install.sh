#! bin/bash

echo $'\nThis script will add a few lines to your .bashrc or .zshrc\nand add some folders in XDG_CONFIG_HOME if exists or in HOME (or HOME/.config) directory if not\nIs this ok for you? Y/n/\n';

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
    if [[ $XDG_CONFIG_HOME ]]
    then
        echo $'\n\nFound your XDG_CONFIG_HOME. Great job!\n\n';
        sleep 0.3;

        echo $'Check your XDG_CONFIG_HOME directory for necessary oglog folder...\n\n';
        if [[ -d "$XDG_CONFIG_HOME/.oglog" ]]
        then
            echo $'Found it!\n\n';
            echo $'Downloading main oglog script...\n\n';
            curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$XDG_CONFIG_HOME/.oglog/oglog.sh";
            sleep 0.3;
        else
            echo $'Creating script specific folder in XDG_CONFIG_HOME directory...\n\n';
            mkdir "$XDG_CONFIG_HOME/.oglog";
            sleep 0.3;

            echo $'Downloading main oglog script...\n\n';
            curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$XDG_CONFIG_HOME/.oglog/oglog.sh";
            sleep 0.3;
        fi
    else
        echo $'\n\nXDG_CONFIG_HOME not found.\nChecking your home directory for .config folder\n\n';
        sleep 0.3;

        if [[ -d "$HOME/.config" ]]
        then
            echo $'Found it!';
            sleep 0.3;

            echo $'Check your HOME/.config directory for necessary oglog folder...\n\n';
            sleep 0.3;
            if [[ -d "$HOME/.config/.oglog" ]]
            then
                echo $'Found it!\n\n';
                echo $'Downloading main oglog script...\n\n';
                curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$HOME/.config/.oglog/oglog.sh";
                sleep 0.3;
            else
                echo $'Creating script specific folder in HOME/.config directory...\n\n';
                mkdir "$HOME/.config/.oglog";
                sleep 0.3;

                echo $'Downloading main oglog script from https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh...\n\n';
                curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$HOME/.config/.oglog/oglog.sh";
                sleep 0.3;
            fi
        else
            echo $'Check your HOME directory for necessary oglog folder...\n\n';
            sleep 0.3;

            if [[ -d "$HOME/.oglog" ]]
            then
                echo $'Found it!\n\n';
                echo $'Downloading main oglog script...\n\n';
                curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$HOME/.oglog/oglog.sh";
                sleep 0.3;
            else
                echo $'Creating script specific folder in HOME directory...\n\n';
                mkdir "$HOME/.oglog";
                sleep 0.3;

                echo $'Downloading main oglog script from https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh...\n\n';
                curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$HOME/.oglog/oglog.sh";
                sleep 0.3;
            fi
        fi
    fi
    ;;
"N" | "n")
    echo "All right :c";
    ;;
esac

unset user_answer;
