#! bin/bash

function oglog_install() {
    local main_script_url="https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh";
    local aliases_url="https://raw.githubusercontent.com/mopqpqua/oglog/master/assets/aliases.sh";
    local config_url="https://raw.githubusercontent.com/mopqpqua/oglog/master/assets/config.sh";
    local script_dir="";
    # https://unix.stackexchange.com/a/120138
    local current_cl=$(ps -p$$ -o cmd="",comm="",fname="" 2>/dev/null | sed 's/^-//' | grep -oE '\w+' | head -n1);
    local config_location="";

    function __oglog_flush() {
        unset main_script_url;
        unset aliases_url;
        unset config_url;
        unset script_dir;
        unset current_cl;
        unset config_location;
        unset user_answer;
        unset user_dir;
        unset confirmation;
    }

    echo $'\nThis script will add a few lines to your .bashrc or .zshrc\nand add some folders in XDG_CONFIG_HOME if exists or in HOME (or HOME/.config) directory if not\nIs this ok for you? Y/n/\n';

    read user_answer;

    case $user_answer in
    "Y" | "y")
        if [[ $XDG_CONFIG_HOME ]]
        then
            echo $'\n\nFound your XDG_CONFIG_HOME. Great job!\n\n';
            echo $'Check your XDG_CONFIG_HOME directory for necessary oglog folder...\n\n';

            if [[ -d "$XDG_CONFIG_HOME/.oglog" ]]
            then
                echo $'Found it!\n\n';
                script_dir="$XDG_CONFIG_HOME/.oglog";
            else
                script_dir="$XDG_CONFIG_HOME/.oglog";
                __oglog_add_folder();
            fi
        else
            echo $'\n\nXDG_CONFIG_HOME not found.\nChecking your home directory for .config folder\n\n';

            if [[ -d "$HOME/.config" ]]
            then
                echo $'Found it!\n\n';
                echo $'Check your HOME/.config directory for necessary oglog folder...\n\n';

                if [[ -d "$HOME/.config/.oglog" ]]
                then
                    echo $'Found it!\n\n';
                    script_dir="$HOME/.config/.oglog";
                else
                    script_dir="$HOME/.config/.oglog";
                    __oglog_add_folder();
                fi
            else
                echo $'Check your HOME directory for necessary oglog folder...\n\n';

                if [[ -d "$HOME/.oglog" ]]
                then
                    echo $'Found it!\n\n';
                    script_dir="$HOME/.oglog";
                else
                    script_dir="$HOME/.oglog";
                    __oglog_add_folder();
                fi
            fi
        fi

        case $current_cl in
        "zsh")
            config_location=$(find ~ -iname .zshrc 2> >(grep -v 'not permitted' >&2));

            if [[ "$config_location" != "" ]]
            then
                echo $'Checking lines in .zshrc\n\n';
                if grep -qF "for f in $script_dir/*; do source "'$f'"; done" "$config_location";
                then
                    echo $'Execution scripts already exists\n\n';
                else
                    echo $'Add some oglog lines to .zshrc...\n\n';
                    __oglog_add_script();
                fi
            else
                echo $'.zshrc not found, lets create it in your HOME!\n\n';
                touch "$HOME/.zshrc";
                config_location="$HOME/.zshrc";

                echo $'Add some oglog lines to $HOME/.zshrc...\n\n';
                __oglog_add_script();
            fi
            ;;
        "bash")
            config_location=$(find ~ -iname .zshrc 2> >(grep -v 'Permission denied' >&2));

            if [[ "$config_location" != "" ]]
            then
                echo $'Checking lines in .bashrc\n\n';
                if grep -qF "for f in $script_dir/*; do source "'$f'"; done" "$config_location";
                then
                    echo $'Execution scripts already exists\n\n';
                else
                    echo $'Add some oglog lines to .bashrc...\n\n';
                    __oglog_add_script();
                fi
            else
                echo $'.bashrc not found, lets create it in your HOME!\n\n';
                touch "$HOME/.bashrc";
                config_location="$HOME/.bashrc";

                echo $'Add some oglog lines to $HOME/.bashrc...\n\n';
                __oglog_add_script();
            fi
            ;;
        esac

        echo $'Downloading main oglog scripts from https://raw.githubusercontent.com/mopqpqua/oglog/master/...\n\n';
        curl -s $main_script_url > "$script_dir/oglog.sh";
        curl -s $aliases_url > "$script_dir/aliases.sh";
        curl -s $config_url > "$script_dir/config.sh";
        echo "OGLOG_FOLDER=\"$script_dir\"" >> "$script_dir/config.sh";
        source "$script_dir/oglog.sh";
        ;;
    "N" | "n")
        echo "You can choose your own directory then, type the path:";
        read user_dir;
        echo "Confirm this directory -> '$user_dir' Y/n/\n";
        read confirmation;

        case $confirmation in
        "Y" | "y")
            echo "Good!\n"
            ;;
        "N" | "n")
            echo "Ok, type the new path:\n"
            ;;
        esac

        # curl -s $main_script_url > "$script_dir/oglog.sh";
        # curl -s $aliases_url > "$script_dir/aliases.sh";
        # curl -s $config_url > "$script_dir/config.sh";
        # echo "OGLOG_FOLDER=\"$script_dir\"" >> "$script_dir/config.sh";
        # source "$script_dir/oglog.sh";
        ;;
    esac

    function __oglog_add_folder() {
        echo $'Creating script specific folder in XDG_CONFIG_HOME directory...\n\n';
        mkdir "$script_dir";
    }

    function __oglog_add_script() {
        echo "" >> "$config_location";
        echo "# oglog script executing and variables" >> "$config_location";
        echo "for f in $script_dir/*; do source "'$f'"; done" >> "$config_location";
        echo "" >> "$config_location";
    }

    __oglog_flush();
}
