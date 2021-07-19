#!/usr/bin/env bash
#!/bin/bash

# Thanks to mjwhitta for making arTTY! (Check it out at https://gitlab.com/mjwhitta/artty)
# Installations needed: weather-util, fortune-mod, arTTY

clear

# colors colors colors colors colors
color=true
err() { echo -e "${color:+\e[31m}[!] $*${color:+\e[0m}" >&2; }
errx() { err "${*:2}"; exit "$1"; }
good() { echo -e "${color:+\e[32m}[+] $*${color:+\e[0m}"; }
info() { echo -e "${color:+\e[37m}[*] $*${color:+\e[0m}"; }
subinfo() { echo -e "${color:+\e[36m}[=] $*${color:+\e[0m}"; }
warn() { echo -e "${color:+\e[33m}[-] $*${color:+\e[0m}"; }

# creates logfile to keep track of updates
logfile=/var/log/kali-update.log
sudo touch $logfile
sudo chmod 666 $logfile

declare -a banner
banner+=("")
banner+=("░██╗░░░░░░░██╗███████╗░█████╗░████████╗██╗░░██╗███████╗██████╗░")
banner+=("░██║░░██╗░░██║██╔════╝██╔══██╗╚══██╔══╝██║░░██║██╔════╝██╔══██╗ ")
banner+=("░╚██╗████╗██╔╝█████╗░░███████║░░░██║░░░███████║█████╗░░██████╔╝")
banner+=("░░████╔═████║░██╔══╝░░██╔══██║░░░██║░░░██╔══██║██╔══╝░░██╔══██╗ ")
banner+=("░░╚██╔╝░╚██╔╝░███████╗██║░░██║░░░██║░░░██║░░██║███████╗██║░░██║")
banner+=("░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝")

i=0

while IFS="" read -r line; do
	echo -e "\e[32m$line ${banner[i]}\e[0m"
	((i+=1))
done < <(cal)

CURRENTDATEONLY=`date +"%b %d, %Y"`

# while loop to create new lines for weather
while read -r line; do
	good "$line"
done < <(weather "nyz072") 

# introduction before updates

cat <<EOF | tee -a $logfile

$(info Current Date and Time is: `date +"%Y-%m-%d %T"`)

$(info "Hello $USER, it's a beautiful day to save lives. Let's have some fun. Your fortune for today is:")

$(warn $(fortune -s))

$(subinfo Doing some housekeeping.	Please stay on standby...)

EOF

# proceed with morning housekeeping

morning () {
	sudo apt-get update -y || return $?
	sudo apt-get upgrade -y || return $?
	sudo apt-get dist-upgrade -y || return $?
	sudo apt-get autoremove -y || return $?
	sudo apt-get autoclean -y || return $?
}

# add improvements for error checking
morning | tee -a $logfile

# successful completion of script
cat <<EOF | tee -a $logfile

$(info The time now is: $(date +"%Y-%m-%d %T"))

$(good "$USER, you're all good to go!")

EOF

# add some arTTY at the end
arTTY -p -r 