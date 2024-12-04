#!/bin/bash

############################
# Telechargement de fichier HARPE
# Frequence d'execution : quotidienne
############################

APP_CONFIG=${APPLI_PARAM}/environnement_dev.conf
DIST_UNZIPPED=${APPLI_COMP}/java/mce/lib/*
LOG_CONFIG=${APPLI_PARAM}/logger.xml
XMS=512m
XMX=512m

#Serveur de recette
SERVEUR_HARPE=nylgdv46.info.ratp
USER_HARPE=mcetrans
ARBO_HARPE=/appli/transfert/data/emet/zu5/V2/personnes/CSV/Full
FICHIER_PERSONNES_FULL=personnes_Full.dat

echo "1- Copie du fichier des agents de Harpe."
$APPLI_SH/import_sftp.sh $SERVEUR_HARPE $USER_HARPE $ARBO_HARPE $APPLI_RECEP $FICHIER_PERSONNES_FULL

#ajout de iconv pour convertir les fichiers d'extraction en utf8 afin de pouvoir les synchroniser avec la base postgres
iconv -f ISO-8859-1 -t UTF-8 ${APPLI_RECEP}/personnes_Full.dat > ${APPLI_RECEP}/personnes_Full.csv

cd /appli/${CA}/var/log > /dev/null 2>&1

echo "2- Import Harpe."
java -Dlogger.file=$LOG_CONFIG -Dconfig.file=$APP_CONFIG -Xms$XMS -Xmx$XMX -cp "$DIST_UNZIPPED" batch.ImportHarpeBatchApp .


exit 0
