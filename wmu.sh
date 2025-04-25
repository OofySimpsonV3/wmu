#!/bin/bash

##
# Discord Webhook Message Utility
# Author: OofySimpsonV3#9137
# Date: 26 Jan 2023
# Last Update: 26 April 2025
##

shopt -s -o nounset # Report undefined variables

## GLOBAL DECLARATIONS
declare -rx SCRIPT=${0##*/}      # Script name
declare -rx curl="/usr/bin/curl" # CURL command binary path

## SANITY CHECKS
if test -z "$BASH" ; then
    printf "[$SCRIPT:$LINENO] Please run this script with the BASH shell...\n" >&2
    exit 192
fi

if test ! -x "$curl" ; then
    printf "[$SCRIPT:$LINENO] The command $curl is not available. Please modify the curl-path variable (LINE 14) and try again..." >&2
    exit 192
fi    

### ------------- CHECKS COMPLETE - SCRIPT START ------------- ###

## DECLARE DEFAULT FALLBACK URL VARIABLE
furl=''

## DECLARE COLOR-CODE VARIABLES
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

## START / MENU FUNCTION
showMenu() {
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

## CLEAR TERMINAL, AND CALL FUNCTION(S) TO INITIATE THE PROGRAM
clear
showMenu
msgprompt
