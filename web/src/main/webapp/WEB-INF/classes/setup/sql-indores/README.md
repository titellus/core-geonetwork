# Catalogue Indores

## Migration

* Copier la base de données du catalogue
* Appliquer [le script SQL de migration](indores-migration.sql) pour passer la version 3.4.4 à la version 4.0.6 de GeoNetwork
* Lancer l'application (cf. [le répertoire de configuration docker](../../../../../../../../docker-indores))
* Appliquer [le script shell de migration](indores-migration.sh) en adaptant l'utilisateur et le mot de passe à utiliser


## Démarrage du catalogue

```shell
mkdir indores-catalogue
cd indores-catalogue
wget https://files.titellus.net/geonetwork/indores/docker-config.zip
unzip docker-config.zip
wget https://files.titellus.net/geonetwork/indores/geonetwork.war

docker-compose up --build
```


## Configuration

* Créer un modèle de saisie ?
* Renommer sample groupe ?


## Moissonnage


Cf. https://docs.google.com/spreadsheets/d/1QoXeB5RYw1HdPMY08eXgN7LIFKnNh9vESaDwbBL3lM8/edit#gid=0


Planifier les moissonneurs sur des plages de temps différentes.
eg. tous les jours à midi `0 0 12 * * ?`, 13h `0 0 13 * * ?`

Assigner un groupe et un utilisateur par défaut.
