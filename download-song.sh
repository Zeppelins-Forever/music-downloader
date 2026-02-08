#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
reset='\033[0m'

############################################################
# Help                                                     #
############################################################
Help()
{
    # Display Help
    printf "Add description of the script functions here.\n\n"
    printf "Syntax: scriptTemplate [-m|p|h|]\n"
    printf "options:\n"
    printf "m     Download content to 'music' folder.\n"
    printf "p     Download content to 'podcasts' folder.\n"
    printf "h     Print this Help.\n"
}

# Update the container
docker pull zeppelinsforever/music-downloader:latest

############################################################
# Process the input options. Add options as needed.        #
############################################################

# Get the options
while getopts "hm:p:" option; do
    case $option in
        h) # display Help
            Help
            exit;;
        m) # download music
            user_input=$OPTARG
            docker run -it --user 999:10 -v /home/ugreen-admin/music/music:/app/output zeppelinsforever/music-downloader:latest $user_input
            printf "\nSent $user_input to Music.\n"
            exit;;
        p) # download a podcast
            user_input=$OPTARG
            docker run -it --user 999:10 -v /home/ugreen-admin/music/podcasts:/app/output zeppelinsforever/music-downloader:latest $user_input
            printf "\nSent $user_input to Podcasts.\n"
            exit;;
        \?) # Invalid option
            printf "Error: Invalid option\n"
            exit;;
    esac
done


printf "What is the URL of the song to download?\n>"
read songURL
choice=""
while [[ "$choice" != "1" && "$choice" != "2" ]]; do
    printf "Would you like to save this audio to the music or podcasts folder?\n[1] music\n[2] podcasts\n>"
    read choice
    case $choice in
        1)
            printf "\nDownloading to Music.\n"
            docker run -it --user 999:10 -v /home/ugreen-admin/music/music:/app/output zeppelinsforever/music-downloader:latest $songURL
            ;;
        2)
            printf "\nDownloading to Podcasts.\n"
            docker run -it --user 999:10 -v /home/ugreen-admin/music/podcasts:/app/output zeppelinsforever/music-downloader:latest $songURL
            ;;
        *)
            printf "${red}Invalid choice, try again.${reset}\n\n"
            sleep 1
            choice=""
            ;;
    esac
done

exit 0
