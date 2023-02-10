#! bin/bash

function oglog_update() {
    local RESTORE="\033[0m";
    local RED="\033[00;31m";
    local GREEN="\033[00;32m";

    if [[ $OGLOG_FOLDER != "" ]]
    then
        rm -rf "$OGLOG_FOLDER/oglog.sh";
        curl "https://raw.githubusercontent.com/mopqpqua/oglog/master/oglog.sh" > "$OGLOG_FOLDER/oglog.sh";
        for f in $OGLOG_FOLDER/*; do source "$f"; done
    else
        echo -e "$RED ERROR$RESTORE: OGLOG_FOLDER not found. You may need to reinstall oglog manually.";
        echo "Visit https://github.com/mopqpqua/oglog";
    fi
}
