#!/bin/bash
echo -e '\n \033[1m ### Written by Akash ###\033[0m\n'
echo -e "\033[31m[+] 1. Print your ip infrmation.
[+] 2. Full ctf recon[start script with root].\033[0m"
read num
if [ $num -eq 1 ]; then
	ifconfig
elif [ $num -eq 2 ]; then
	echo ' Enter the ip for port scan:'
	read ip
	echo -e "\033[32m[*]  port scanning...\033[0m"
	nmap -sS $ip | grep -A 30 'Nmap scan report'
	echo -e "\033[32m[*] port enumerating...\033[0m"
	nmap -sV -sC $ip | grep -A 30 "Nmap scan report"
	echo -e "\033[32m[*]directory enumerating... at 80\033[0m"
	gobuster dir -u http://$ip:80 -w /usr/share/wordlists/dirb/common.txt | grep -A 50 'Starting gobuster'
	echo 'for dir-enum on another port give the port no'
	echo 'or press other keys to exit.'
	read port
	if [[ $port =~ ^[0-9]+$ ]]; then
  		gobuster dir -u http://$ip:$port -w /usr/share/wordlists/dirb/common.txt | grep -A 50 'Starting gobuster'
	else
  		echo "closing ctfrecon"
	fi
	
	
else
	echo 'wrong input, sorry!!'	
	
fi	

