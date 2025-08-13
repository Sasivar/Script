#!/bin/bash

figlet -f big SimplEnum 

echo -e "\nNOTE: If the HTB machine redirects to a domain name, make sure to map the IP address to that hostname in your /etc/hosts file\n"

read -p "Enter the Hostname or IP: " HOST

#  Wordlists
DIR_WORDLIST=" "              #---->Enter wordlist path
SUBDOMAIN_WORDLIST=" "        #---->Enter wordlist path

# User Options
while true; do
    echo ""
    echo "Select an action to perform:"
    echo "1) Nmap Scan"
    echo "2) Directory Enumeration (Gobuster)"
    echo "3) Subdomain Enumeration (Gobuster DNS)"
    echo "4) SMB Enumeration"
    echo "5) FTP Enumeration"
    echo "6) Exit"
    read -p "Enter your choice [1-6]: " CHOICE

    if [ "$CHOICE" -eq 1 ]; then
        echo "[+] Running Nmap scan on $HOST..."
        nmap -T4 -A -Pn -sV "$HOST"

    elif [ "$CHOICE" -eq 2 ]; then
        read -p "Enter port (e.g., 80 or 443): " PORT
        if [ "$PORT" -eq 443 ]; then
            URL="https://$HOST"
        else
            URL="http://$HOST:$PORT"
        fi
        echo "[+] Running Gobuster DIR on $URL..."
        gobuster dir -u "$URL" -w "$DIR_WORDLIST" -x php,txt,html -t 40 --no-error

    elif [ "$CHOICE" -eq 3 ]; then
        echo "[+] Running Gobuster DNS on $TARGET..."
        gobuster dns -d "$HOST" -w "$SUBDOMAIN_WORDLIST" -t 50 -r --no-error

    elif [ "$CHOICE" -eq 4 ]; then
        echo "[+] Running SMB Enumeration..."
        smbmap -H "$HOST"
        enum4linux "$HOST"

    elif [ "$CHOICE" -eq 5 ]; then
        echo "[+] Checking FTP access..."
        echo "Trying anonymous login..."
        read -p "Do you have a valid FTP credentials.. (y/n): " CRED

        if [[ "$CRED" == "y" || "$CRED" == "Y" ]]; then
            read -p "Enter FTP username: " FTP_USER
            read -p "Enter FTP password: " FTP_PASS        
            echo ""
            echo "[+] Trying login with provided credentials..."
            ftp -inv "$HOST" <<EOF
user $FTP_USER $FTP_PASS
ls
quit
EOF
        else
            echo "[+] Trying anonymous login..."
            ftp -inv "$HOST" <<EOF
user anonymous anonymous
ls
quit
EOF
        fi

    elif [ "$CHOICE" -eq 6 ]; then
        echo "[*] Exiting !!"
        break

    else
        echo "[-] Invalid choice. Please select a valid option."
    fi
done
