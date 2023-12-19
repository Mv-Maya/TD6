#!/bin/bash

#demande du login de l'utilisateur qui a les droits sur la base "glpi"
echo "Saisir le nom d'utilisateur ayant les droits d'écriture sur la base glpi"
read login

#demande du mot de passe de cet utilisateur
#desactivation de l'affichage de la saisie clavier
stty -echo
echo "Saisir le mot de passe de cet utilisateur"
read mdp

#reactivation l'affichage de la saisie clavier
stty echo

#Sauvegarde de la base de donnees glpi au format sql
echo "Sauvegarde : export de la base de donnees sous le nom glpiSauvAvantMAJ.sql dans le repertoire courant"
mysqldump -u $login -p$mdp glpi > glpiSauvAvantMAJ.sql

#si la sauvegarde ne peut pas se faire 
if [ $? -ne 0 ]
then
	#affichage un message d'erreur et arret du script
	echo "Impossible de sauvegarder la base de données. Arrêt du script."
	exit 10
else
	echo "Sauvegarde effectuée."
fi

#ajout des batiments et des salles dans la base "glpi"
echo "Creation des batiments et des etages"
mysql -u $login -p$mdp < creationBatEtage.sql

#si l'ajout ne peut pas se faire 
if [ $? -ne 0 ]
then
	#affichage un message d'erreur et arret du script
	echo "Creation des batiments et etages impossible. Arrêt du script."
	exit 20
else
	echo "Creation des batiments et des etages effectuée."
fi

#parcours du fichier listeSalles.txt
cat listeSalles.txt | while read ligne
do
        set $ligne

	#recuperation du premier et du deuxieme caractère de la salle
        salle=`echo $1 `
        premier=`echo ${salle:0:1} `
        deuxieme=`echo ${salle:1:1} `
        
	# en fonction de la salle, on connait le lieu à associer
	# pour les salles de type entier
        if [ -z "`echo $1 | sed s/[0-9]*//`" ]
        then
                #en fonction du premier chiffre
                #si 2 alors salle du batiment 2
                #si 3 alors salle du batiment 3
                #sinon (si 0 ou 1) alors salle du batiment 1
                
                if [ $premier -eq 2 ]
                then
                	#batiment 2
                	#etage = deuxieme chiffre + 1            
                	etage=`expr $deuxieme + 1 `
                	
                	#forcement dans "B2 > E$etage
                	parent=`echo "B2 > E$etage" `
                	
                else
                	#batiment 1 ou 3
                	#deuxieme chiffre correspond à l'etage             
					
			case $premier in
			0|1) parent=`echo "B1 > E$deuxieme" `;;
			3) parent=`echo "B3 > E$deuxieme" `;;
			esac
                fi
        else 
			case $ligne in
			"sdp"|"LT") parent="B1 > E1" ;;
			"CDI") parent="B3 > E0" ;;
			"svt") parent="B3 > E2" ;;
			P0*) parent="B1 > E0" ;;
			P1*) parent="B1 > E2" ;;
			esac
        fi

		#verification de l'existence de la salle dans la base de donnees 
		req=`echo "USE glpi; SELECT name FROM glpi_locations WHERE name ='$ligne' ;" | mysql -u $login -p$mdp -N`
		     
		# si la requete ne renvoit rien, $req est vide
		if [ -z ${req} ]
		then
			#création de la salle car elle n'existe pas
			echo "USE glpi; INSERT INTO glpi_locations (name, completename, locations_id, level) VALUES ('$ligne', '$parent > $ligne', (SELECT provisoire.id FROM glpi_locations AS provisoire WHERE provisoire.completename='$parent'), 2);" | mysql -u $login -p$mdp
		else
			#sinon, la salle existe, mise à jour sa localisation
			echo "USE glpi; UPDATE glpi_locations SET locations_id=(SELECT id FROM (SELECT * FROM glpi_locations AS provisoire WHERE provisoire.completename='$parent') AS tableTemporaire), completename='$parent > $ligne', level=2 WHERE name='$ligne' ;" | mysql -u $login -p$mdp
		fi
		query="USE glpi; UPDATE glpi_computers
		SET locations_id = COALESCE(
			CASE
				WHEN LEFT(glpi_computers.name, 3) = 'ser' AND (SELECT id FROM glpi_locations WHERE name = 'LT' LIMIT 1) IS NOT NULL THEN
					(SELECT id FROM glpi_locations WHERE name = 'LT' LIMIT 1)
				WHEN LEFT(glpi_computers.name, 3) != 'ser' AND (SELECT id FROM glpi_locations WHERE LEFT(glpi_computers.name, 3)
				 = LEFT(glpi_locations.name, 3) LIMIT 1) IS NOT NULL THEN
					(SELECT id FROM glpi_locations WHERE LEFT(glpi_computers.name, 3) = LEFT(glpi_locations.name, 3) LIMIT 1)
			END, locations_id);"
		echo $query | mysql -u $login -p$mdp


done

echo "Mise à jour terminée"
