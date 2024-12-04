#!/bin/bash
# * Script de deploiement de play
# *
# * Ce script permet de passer un patch pour la partie PLAY
# * Il permet également de faire un retour arrière en cas de problème.
# * il est assimilé aux PEU et doit être exécuter en tant que root par l'exploitant informatique
# *
# * By /SIT/CPS/IDS
# * @copyright (c) RATP 2012
# * @version 1.0
# * @os Linux
# *
# * Régles :
# * Ce script doit être placé sous /appli/$CodeAppli/comp/util avec les droits exploit:bsq 750 à lancer en root
# * Le fichier zip est à déposer sous /appli/$CodeAppli/comp/livraison et devra être nommé $CodeAppli-1.0-SNAPSHOT.zip
# * Passer en paramétre au shell le nom du répertoire à patcher

function message
{

echo "Parametre manquant

Liste des parametres :

-a aide
-c code applicatif
-r rollback
-f FichierSnap

2 utilisations possibles ex :

    - ./DeploiementProd.sh -c gdd -f gdd-1.0-SNAPSHOT.zip
    - ./DeploiementProd.sh -c gdd -r rollback

"
}



while getopts ac:f:r: options
do
   case "${options}" in
      a)clear
        message
        exit
        ;;
      c)CodeAppli=${OPTARG};;
      f)FichierSnap=${OPTARG};;
      r)Rollback=${OPTARG};;
    esac
done

if [ "$CodeAppli" =  "" ]
then
   $0 -a
    exit
fi
                if [ "${Rollback}" != "" ]
                then
                       if [ "${Rollback}" = "rollback" ] && [ "$CodeAppli" !=  "" ] && [ "$FichierSnap" = "" ]
                       then
                                #Verification de Presence d'une Sauvegarde
                                if [ -f /appli/$CodeAppli/comp/livraison/ROLLBACK_PLAY.tar ]
                                then
                                        echo " RollBack de PLAY"
                                        tar -Pxvf /appli/$CodeAppli/comp/livraison/ROLLBACK_PLAY.tar > /dev/null 2>&1
                                        sleep 1
                                        echo "Traitement terminé avec succés"
                                        exit
                                else
                                echo "Pas de fichier de Rollback trouvé sous /appli/$CodeAppli/comp/livraison/"
                                fi
                       else
                           $0 -a
               exit
                       fi
                fi

                if [ "$CodeAppli" !=  "" ] &&  [ "$FichierSnap" != "" ] && [ "${Rollback}" = "" ]
                then
            if    [ -f "/appli/$CodeAppli/comp/livraison/${FichierSnap}" ]
            then
                FichierSnap_ext=$( echo $FichierSnap | awk -F '.zip'  '{print$1}')
                #Sauvegarde de l'ancienne arborescence
                echo "Sauvegarde de l'arborescence existante"
                tar -Pcvf /appli/$CodeAppli/comp/livraison/ROLLBACK_PLAY.tar /appli/$CodeAppli/comp/java/* > /dev/null 2>&1
                sleep 1

                    echo "Deploiement de la nouvelle version de PLAY"
                # Copie du nouveau zip
                    cd /appli/$CodeAppli/comp/java
                                       rm -rf $CodeAppli
                    cp /appli/$CodeAppli/comp/livraison/$FichierSnap /appli/$CodeAppli/comp/java
                    # Dezippage du fichier
                    unzip $FichierSnap
                        # Modification du nom du repertoire pour simplifier le lancement de play
                    mv ${FichierSnap_ext} $CodeAppli
                    rm ${FichierSnap}
                    cd /appli/$CodeAppli/comp/java/$CodeAppli
                    rm README start
                    chmod -R 750 /appli/$CodeAppli/comp/java
                    chown -R exploit:$CodeAppli /appli/$CodeAppli/comp/java
                    chmod 640 /appli/$CodeAppli/comp/java/$CodeAppli/lib/*
                    sleep 1
                    echo "Traitement terminé avec succés"

        else
                echo "Pas de fichier  $FichierSnap trouvé"
                exit
            fi
        fi
if [ "$CodeAppli" !=  "" ] &&  [ "$FichierSnap" = "" ] && [ "${Rollback}" = "" ]
then
    $0 -a
    exit
fi
