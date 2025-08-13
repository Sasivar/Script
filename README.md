# SimplEnum - Modular Enumeration Script

SimplEnum is a Bash-based interactive enumeration script designed for penetration testers and CTF enthusiasts. It supports scanning and probing common services like HTTP, SMB, FTP, and DNS with a menu-driven interface.

---

## Features

- Nmap full port scan with service detection
- Directory brute-forcing using Gobuster
- Subdomain enumeration with Gobuster DNS
- SMB enumeration using smbmap and enum4linux
- FTP login testing (anonymous or credentialed)
- Interactive menu with persistent session

---

## Requirements

Make sure the following tools are installed and accessible in your `$PATH`

- `nmap`
- `gobuster`
- `smbmap`
- `enum4linux`
- `ftp` (standard CLI client)

Also ensure to add your wordlist Path to the script under

- DIR_WORDLIST=" "
- SUBDOMAIN_WORDLIST-" "

---

## Usage

```bash
chmod +x SimplEnum.sh
./SimplEnum.sh


---

## Disclaimer

This tool is intended for educational and authorized testing purposes only. Use responsibly and only on systems you have permission to test.

