#!/bin/sh

#Note: I'm using !/bin/sh instad of /bin/bash as Alpine doesn't natively ship with bash.

#define various color variables:
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
reset='\033[0m' # Resets to default color

# Check number of arguments
if [ $# -eq 1 ]; then #if only one argument exists, assume it's the target URL and attempt a download.
    printf "${green}Downloading audio!${reset}\n"
    yt-dlp -x -f bestaudio --embed-metadata --embed-thumbnail --no-cache-dir -o "/app/output/%(title)s.%(ext)s" $1
    exit 1
elif [ $# -gt 1 ]; then #if more than one argument exists, warn the user and close the program.
    printf "${red}Too many arguments, just include the URL!${reset}\n"
    exit 2
fi

# If no arguments were provided, the script continues from here
printf "${yellow}No arguments were provided. Continuing with the script...${reset}\n\n"
printf "What is the URL of the song you wish to download?\n>"
read user_song_URL

# Remove all whitespace (spaces, tabs, newlines) from the variable
user_song_URL_no_space=$(echo "$user_song_URL" | tr -d '[:space:]')

yt-dlp -x -f bestaudio --embed-metadata --embed-thumbnail --no-cache-dir -o "/app/output/%(title)s.%(ext)s" $user_song_URL_no_space
printf "\n${green}Done!${reset}\n"

exit 0
