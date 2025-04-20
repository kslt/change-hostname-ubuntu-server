#!/bin/bash

# Fråga efter nytt hostname
read -p "Ange nytt hostname: " NYTT_HOSTNAME

# Kontrollera att något angavs
if [ -z "$NYTT_HOSTNAME" ]; then
    echo "Inget hostname angavs. Avbryter."
    exit 1
fi

echo "Sätter nytt hostname till: $NYTT_HOSTNAME"

# Ändra hostname temporärt och permanent
hostnamectl set-hostname "$NYTT_HOSTNAME"
hostname "$NYTT_HOSTNAME"

# Uppdatera /etc/hosts
echo "Uppdaterar /etc/hosts..."
sed -i "s/127.0.1.1\s.*/127.0.1.1\t$NYTT_HOSTNAME/" /etc/hosts

echo "Klart! Ditt hostname är nu: $NYTT_HOSTNAME"
echo

read -p "Vill du starta om nu? (j/n): " VAL
if [[ "$VAL" == "j" || "$VAL" == "J" ]]; then
    echo "Startar om..."
    reboot
else
    echo "Starta om manuellt senare för att allt ska gälla fullt ut."
fi
