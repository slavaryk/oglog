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
            script_dir="$XDG_CONFIG_HOME/.oglog";
        else
            echo $'Creating script specific folder in XDG_CONFIG_HOME directory...\n\n';
            mkdir "$XDG_CONFIG_HOME/.oglog";
            sleep 0.3;

            echo $'Downloading main oglog script...\n\n';
            curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$XDG_CONFIG_HOME/.oglog/oglog.sh";
            sleep 0.3;
            script_dir="$XDG_CONFIG_HOME/.oglog";
        fi
    else
        echo $'\n\nXDG_CONFIG_HOME not found.\nChecking your home directory for .config folder\n\n';
        sleep 0.3;

        if [[ -d "$HOME/.config" ]]
        then
            echo $'Found it!\n\n';
            sleep 0.3;

            echo $'Check your HOME/.config directory for necessary oglog folder...\n\n';
            sleep 0.3;
            if [[ -d "$HOME/.config/.oglog" ]]
            then
                echo $'Found it!\n\n';
                echo $'Downloading main oglog script...\n\n';
                curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$HOME/.config/.oglog/oglog.sh";
                sleep 0.3;
                script_dir="$HOME/.config/.oglog";
            else
                echo $'Creating script specific folder in HOME/.config directory...\n\n';
                mkdir "$HOME/.config/.oglog";
                sleep 0.3;

                echo $'Downloading main oglog script from https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh...\n\n';
                curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$HOME/.config/.oglog/oglog.sh";
                sleep 0.3;
                script_dir="$HOME/.config/.oglog";
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
                script_dir="$HOME/.oglog";
            else
                echo $'Creating script specific folder in HOME directory...\n\n';
                mkdir "$HOME/.oglog";
                sleep 0.3;

                echo $'Downloading main oglog script from https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh...\n\n';
                curl -s "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$HOME/.oglog/oglog.sh";
                sleep 0.3;
                script_dir="$HOME/.oglog";
            fi
        fi
    fi

    if [[ $0 == "-zsh" ]]
    then
        echo $'Check if youre using ZDOTDIR\n\n';
        if [[ $ZDOTDIR ]]
        then
            echo $'Found it!\n\n';

            if [[ -f "$ZDOTDIR/.zshrc" ]]
            then
                echo $'Checking lines in ZDOTDIR/.zshrc\n\n';
                if grep -qF "for f in $script_dir/*; do source "'$f'"; done" $ZDOTDIR/.zshrc;
                then
                    echo $'Execution scripts already exists\n\n';
                else
                    echo $'Add some oglog lines to ZDOTDIR/.zshrc...\n\n';

                    echo "" >> "$ZDOTDIR/.zshrc";
                    echo "# oglog script executing" >> "$ZDOTDIR/.zshrc";
                    echo "for f in $script_dir/*; do source "'$f'"; done" >> "$ZDOTDIR/.zshrc";

                    source "$script_dir/oglog.sh";
                fi
            else
                echo $'.zshrc not found, lets create it in you ZDOTDIR!\n\n';
                touch "$ZDOTDIR/.zshrc";
                sleep 0.3;

                echo $'Add some oglog lines to ZDOTDIR/.zshrc...\n\n';

                echo "" >> "$ZDOTDIR/.zshrc";
                echo "# oglog script executing" >> "$ZDOTDIR/.zshrc";
                echo "for f in $script_dir/*; do source "'$f'"; done" >> "$ZDOTDIR/.zshrc";

                source "$script_dir/oglog.sh";
            fi
        else
            echo $'ZDOTDIR not found ;c\n\n';
            if [[ -f "$HOME/.zshrc" ]]
            then
                echo $'Checking lines in HOME/.zshrc\n\n';
                if grep -qF "for f in $script_dir/*; do source "'$f'"; done" $HOME/.zshrc;
                then
                    echo $'Execution scripts already exists\n\n';
                else
                    echo $'Add some oglog lines to HOME/.zshrc...\n\n';

                    echo "" >> "$HOME/.zshrc";
                    echo "# oglog script executing" >> "$HOME/.zshrc";
                    echo "for f in $script_dir/*; do source "'$f'"; done" >> "$HOME/.zshrc";

                    source "$script_dir/oglog.sh";
                fi
            else
                echo $'.zshrc not found, lets create it in you HOME!\n\n';
                touch "$HOME/.zshrc";
                sleep 0.3;

                echo $'Add some oglog lines to HOME/.zshrc...\n\n';

                echo "" >> "$HOME/.zshrc";
                echo "# oglog script executing" >> "$HOME/.zshrc";
                echo "for f in $script_dir/*; do source "'$f'"; done" >> "$HOME/.zshrc";

                source "$script_dir/oglog.sh";
            fi
        fi
    else
        echo $'Checking lines in HOME/.bashrc\n\n';
        if grep -qF "for f in $script_dir/*; do source "'$f'"; done" $HOME/.bashrc;
        then
            echo $'Execution scripts already exists\n\n'
        else
            echo $'Add some oglog lines to HOME/.bashrc...\n\n';

            echo "" >> "$HOME/.bashrc";
            echo "# oglog script executing" >> "$HOME/.bashrc";
            echo "for f in $script_dir/*; do source "'$f'"; done" >> "$HOME/.bashrc";

            source "$script_dir/oglog.sh";
        fi
    fi
    ;;
"N" | "n")
    echo "All right :c";
    ;;
esac

unset script_dir;
unset user_answer;
