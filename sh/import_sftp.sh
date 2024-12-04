#!/bin/bash

###################################################################
# @script : import_fichier_harpe.sh                              #
# @date : 20/04/10                                              #
# @version : 0.1                                                  #
# @desciption : Script de transfert des fichiers    #
# de  harpe ou serf rh vers servicerh.info.ratp par SFTP  #
# @arg 1: nom du serveur
# @arg 2: nom du user pour la connexion
# @arg 3: path du fichier distant
# @arg 4: arbo locale ou ecrire les fichiers
# @arg 5: nom du fichier distant (optionnel)
#                                                                 #
###################################################################


#################################
### variables initialisation ####
#################################

SERVER=$1
USERDISTANT=$2
DIR_PATH_SOURCE=$3
DIR_PATH_DESTINATION=$4

fonction_erreur()
{
	DATE_SYS=`date +%Y-%m-%d-%H.%M.%S `;echo "[${DATE_SYS}] [error] ${1} ___";
    exit 1
}


if [ "$#" = "5" ]; then
	FILENAME=$5
        echo "telechargement unitaire $USERDISTANT@$SERVER:$DIR_PATH_SOURCE/$FILENAME $DIR_PATH_DESTINATION/"
	scp $USERDISTANT@$SERVER:$DIR_PATH_SOURCE/$FILENAME $DIR_PATH_DESTINATION/
	RETURN_SFTP=$?
else
	echo "telechargement d'un repertoire"
	scp -r $USERDISTANT@$SERVER:$DIR_PATH_SOURCE $DIR_PATH_DESTINATION/
	RETURN_SFTP=$?
fi

if [ $RETURN_SFTP != 0 ]; then
		fonction_erreur "SFTP KO -->EXIT"
fi


exit 0
