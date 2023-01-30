#!/bin/bash

SCRIPT=$( basename "$0" )

# Function for display helping menu
def_help() {
   echo
   echo "Usage: $SCRIPT [options]"
   echo
   echo "Options:"
   echo
   echo "    --all       Displays the IP addresses and symbolic names of"
   echo "                all hosts in the current subnet"
   echo "                This option requires net-tools package installed"
   echo
   echo "    --target    Displays a list of open system TCP ports"
   echo "                This option requires net-tools package installed"
   echo
}

# Function for finding neighboring hosts in subnet 
def_hosts () {
   command -v arp > /dev/null 2>&1 || { echo >&2 "Net-tools package installation is required. Aborting."; exit 1; }
   echo "Hosts in current subnet:"
   arp -a | awk '{print $2, $1}' | sed 's/[()]//g' | sort -V
   echo
}

# Alternative application using nmap for /24 subnets
# subnets="$(ip a | grep "global" | cut -d ' ' -f 6 | cut -d '/' -f 1 | cut -d '.' -f 1,2,3)"
# def_hosts () {
# for i in $@
#    do
#    nmap -sP $i.0/24 -oG - | awk '/Up$/{print $2, $3}' | sed 's/[()]//g' | sort -V
#    done; }


# Function for finding open system TCP ports
def_ports () {
   command -v netstat > /dev/null 2>&1 || { echo >&2 "Net-tools package installation is required. Aborting."; exit 1; }
   echo "Open TCP ports:"
   netstat -ltn | awk '/LISTEN/{print $4}' | sed 's/.*://g' | sort -n | uniq | sed ':a; N; $!ba; s/\n/, /g'
   echo 
}

# Start of application
if [[ $# -gt 0 ]]; then
	while [[ -n "$1" ]]; do case "$1" in
		--all) def_hosts ;; 
		--target) def_ports ;;
		*) echo "Option $1 not recognized"  ;;
		esac
		shift
	done
else def_help
fi
