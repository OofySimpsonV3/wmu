#!/bin/bash

##
# Discord Webhook Message Utility
# Author: OofySimpsonV3#9137
# Date: 26 Jan 2023
##

clear

## DEFAULT FALLBACK URL
furl=''

## COLORS

Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

## STARTUP FUNCTION
startup() {
    echo -e "SYSTEM > ${Green}Discord Webhook Message Utility${White}"
    echo -e "SYSTEM > ${White}Script written by OofySimpsonV3 ${Cyan}(Github)${White}"
    echo -e "SYSTEM > ${Red}WARNING: ${White}Webhooks are ${Yellow}POST ONLY! ${White}There is no way to recieve messages via Discord Webhooks.${White}"
    echo -e "SYSTEM > ${Green}Thank you for using this script!${White}"
    echo -e "SYSTEM > ${White}Please enter the ${Cyan}URL${White} to your ${Cyan}Webhook...${White}"
    echo -e -n "INPUT > ${Purple}"
    read url

    if [[ $url == $NULL ]]; then
        echo -e "${White}SYSTEM > ${Red}No URL provided. Resorting to fallback URL...${White}"
        if [[ $furl == $NULL ]]; then
            echo -e "${White}SYSTEM > ${Red}ERROR: No fallback URL provided. Please actually set a URL...${White}"
            echo -e "SYSTEM > ${Red}FATAL ERROR: Aborting...${White}"
            exit 1
        else
            url="$furl"
        fi
    else
        echo -e "${White}SYSTEM > ${Green}Good-o!${White} You may now send messages."
    fi 
}


## FUNCTION FOR SENDING MESSAGE
sendmsg() {
    msg_content=\"$message\"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
}

## FUNCTION MESSAGE INPUT PROMT
msgprompt() {
    echo -n "MSG > "
    read message

    case $message in 
        "$NULL")
            echo -e "SYSTEM > ${Red}ERROR: That's not a fucking message! thats blank you spoon${White}"
            msgprompt
            ;;

        "//exit")
            echo -e "SYSTEM > ${Red}Exiting...${White}"
            exit 0
            ;;

        "//clear")
            clear
            msgprompt
            ;;

        *)
            sendmsg
            msgprompt
            ;;
    esac
}

## COMMANDS ON STARTUP

startup
msgprompt
