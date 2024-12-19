#!/usr/bin/bash
function notify(){
    notify-send "$1"
    printf "$1"
}
