#! /bin/bash

today=$(date +%Y%m%d) #Récupérer la date du jour
weather_report=raw_data_$today #Nom du fichier de sortie
curl wttr.in/casablanca --output $weather_report #Récupérer les données météo de Casablanca

grep °C $weather_report > temperatures.txt #Extraire les températures

obs_tmp=$(head -1 temperatures.txt | tr -s " " | xargs | rev | cut -d " " -f2 | rev) #Température observée
echo $obs_tmp
fc_temp=$(head -3 temperatures.txt | tail -1 | tr -s " " | xargs | cut -d "C" -f2 | rev | cut -d " " -f2 | rev) # Température prévue
echo $fc_temp

hour=$(TZ='Morocco/Casablanca' date -u +%H) #Heure actuelle
jour=$(TZ='Morocco/Casablanca' date -u +%d) #Jour actuel
mois=$(TZ='Morocco/Casablanca' date +%m) #Mois actuel
annee=$(TZ='Morocco/Casablanca' date +%Y) #Année actuelle

echo -e "$annee\t$mois\t$jour\t$hour\t$obs_temp\t$fc_temp\t$fc_temp" >> rx_poc.log #Enregistrer les données dans un fichier