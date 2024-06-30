#!/bin/bash

# Aggiorna i pacchetti di sistema
apt-get update && apt-get upgrade -y

# Installa le dipendenze necessarie (se non sono già presenti)
apt-get install -y \
    wget \
    curl #\
    #git \
    #python3 \
    #python3-pip \
    #build-essential 

#source /home/frappe/.nvm/nvm.sh
#nvm alias default 18
#nvm use 18
#echo "nvm use 18" >> ~/.bashrc

# Scarica e installa lo script di installazione di Frappe
wget https://raw.githubusercontent.com/frappe/frappe_docker/main/development/installer.py


#echo "[]" > apps-example.json
# Crea il file apps-example.json (includi Frappe ed ERPNext)
echo "[
  { \"url\": \"https://github.com/frappe/erpnext.git\", \"branch\": \"version-15\" }
]" > apps-example.json

chmod +x installer.py
# Esegui lo script di installazione di Frappe
./installer.py --verbose  # Aggiungi --verbose per vedere l'output dettagliato

# Imposta i permessi corretti dopo l'installazione
sudo chown -R frappe:frappe /home/frappe/benches

# Avvia i bench di Frappe
cd /home/frappe/benches/frappe-bench
bench start

# Output finale
echo "Installazione completata. Frappe ed ERPNext dovrebbero essere in esecuzione."
