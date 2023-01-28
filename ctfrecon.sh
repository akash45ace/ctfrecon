#!/bin/bash
echo -e "\e[31m" '[+] 1. print your ip infrmation.
 [+] 2. do a full ctf recon[start script with root]'
echo -e '\e[0m'
read num
if [ $num -eq 1 ]; then
	ifconfig
elif [ $num -eq 2 ]; then
	echo ' Enter the ip for port scan'
	read ip
	echo -e "\e[32m"	
	echo '[*]  port scan'
	echo -e "\e[0m"
	nmap -sS $ip | grep -A 30 'Nmap scan report'
	echo -e "\e[32m"
	echo '[*] port enumeration'
	echo -e "\e[0m"
	nmap -sV -sC $ip | grep -A 30 "Nmap scan report"
	echo -e "\e[32m"
	echo '[*]directory enum at 80'
	echo -e "\e[0m"
	gobuster dir -u http://$ip:80 -w /usr/share/SecLists-master/Discovery/Web-Content/common.txt | grep -A 50 'Starting gobuster'
	echo 'if it is on another port give me port no'
	read port
	if [ $# -eq 0 ]; then
	       echo 'no imput given'
	else
 		gobuster dir -u http://$ip:$port -w /usr/share/SecLists-master/Discovery/Web-Content/common.txt | grep -A 50 'Starting gobuster'
	fi
	
	
else
	echo 'wrong input, sorry!!'	
	
fi	

