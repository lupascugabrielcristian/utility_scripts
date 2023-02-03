#!/bin/bash
# bitwarden.sh
# 
# Description:
# Porneste aplicatia Bitwarden-2023.1.1-x86_64.AppImage in alt process pentru a nu bloca terminalul si trimte la /dev/null output-ul
# Dupa executie inchide terminalul de unde am pornit comanda
# 
# Usage: ./bitwarden.sh
# 	input format: -
# 

2>/dev/null 1>/dev/null /home/alex/apps/Bitwarden-2023.1.1-x86_64.AppImage &

sleep 1

kill -25 $PPID
