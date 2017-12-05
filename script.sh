#!/bin/bash
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m' # Cyan

echo -e "$Cyan \n Installation d'Apache2 en cours $Color_Off"
sudo apt-get install apache2 -y
echo -e "$Green \n Apache2 Installé ! $Color_Off"

echo -e "$Cyan \n Installation de PHP 7.0 en cours $Color_Off"
sudo apt-get install php7.0 libapache2-mod-php7.0 php7.0-mysql -y
echo -e "$Green \n PHP 7.0 et dépendances Apache2 et MySQL Installés ! $Color_Off"

sudo rm index.html

echo -e "$Cyan Installation de wordpress $Color_Off"
sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
sudo chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
sudo wp core download --allow-root
echo -e "$Yellow \n Quel est le titre de votre site ? (veuillez rentrer un seul mot)$Color_Off"
read title
echo -e "$Yellow \n Choisissez votre nom d'utilisateur :$Color_Off"
read user
echo -e "$Yellow \n Choisissez votre mot de passe : $Color_Off"
read password
echo -e "$Yellow \n Rentrez votre adresse email : $Color_Off"
read email
sudo wp config create --dbname=wordpress --dbuser=root --dbpass=0000 --dbhost=localhost --allow-root
sudo wp core install --url=192.168.33.10 --title=$title --admin_user=$user --admin_password=$password --admin_email=$email --allow-root

echo -e "$Yellow \n Voulez vous gérer les thèmes ? $Color_Off"
read themeAgree
if [[ "$themeAgree" =~ ^(y|Y)$ ]]
    choice=("Ajouter un thème" "Supprimer un thème" "Activer un thème" "Quitter")
    then select response in "${choice[@]}"
        do case $response in
            "Ajouter un thème" ) echo "raclette";;
            "Supprimer un thème" ) echo "choco";;
            "Activer un thème" ) echo "pistache";;
            "Quitter") $themeAgree = "n";break;;
            esac
        done
fi
if [[ "$themeAgree" =~ ^(n|N)$ ]]
 then echo -e "$Yellow \n Voulez vous gérer les plugins ? [y/n]$Color_Off"
     read pluginAgree

else echo "moustache"

fi
sudo service apache2 restart
echo -e "$Green \n Serveur apache redémarré, vous pouvez accéder à votre site wordpress sur 192.168.33.10 ! Enjoy ! $Color_Off"

