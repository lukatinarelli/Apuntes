#!/bin/bash

function ctrl_c(){
  echo -e "\n[!] Saliendo..."
  tput cnorm
  exit 1
}

# Ctrl + C 
trap ctrl_c SIGINT

tput civis

declare -a ports=( $(seq 1 65535) )

function checkport(){
  (exec 3<> /dev/tcp/$1/$2) 2>/dev/null

  if [ $? -eq 0 ]; then
    echo "[+] Host $1 - Puerto $2 abierto"
  fi

  exec 3<&- 3>&-
}

if [ $1 ]; then
  for port in ${ports[@]}; do
    checkport $1 $port & 
  done
else
  echo -e "\n[!] Uso: $0 <ip-address>"

fi

wait

tput cnorm
