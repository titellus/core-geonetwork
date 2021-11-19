# Catalogue Indores

## Migration

* Copier la base de données du catalogue
* Appliquer [le script SQL de migration](indores-migration.sql) pour passer la version 3.4.4 à la version 4.0.6 de GeoNetwork
* Lancer l'application (cf. [le répertoire de configuration docker](../../../../../../../../docker-indores))
* Appliquer [le script shell de migration](indores-migration.sh) en adaptant l'utilisateur et le mot de passe à utiliser


```shell
cd /home/aggregate
mkdir indores-catalogue
cd indores-catalogue
wget https://files.titellus.net/geonetwork/indores/geonetwork.war
wget https://files.titellus.net/geonetwork/indores/docker-config.zip
unzip docker-config.zip


docker-compose up -d --build database
psql -U mnhn -W -p 13432 -h localhost -d geonetwork -f ../sauvegarde_old_geonetwork/dump_20211104.sql


wget https://raw.githubusercontent.com/titellus/core-geonetwork/indores-4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql-indores/indores-migration.sql
psql -U mnhn -W -p 13432 -h localhost -d geonetwork -c "SELECT value FROM settings WHERE name LIKE '%version%';"
# Return 3.4.4
psql -U mnhn -W -p 13432 -h localhost -d geonetwork -f indores-migration.sql
psql -U mnhn -W -p 13432 -h localhost -d geonetwork -c "SELECT value FROM settings WHERE name LIKE '%version%';"
# Return 4.0.6

docker-compose up -d --build geonetwork www elasticsearch kibana

wget https://raw.githubusercontent.com/titellus/core-geonetwork/indores-4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql-indores/indores-migration.sh
chmod +x indores-migration.sh
./indores-migration.sh
```


## Configuration

* Créer un modèle de saisie ?
* Renommer sample groupe ?


## Moissonnage

Cf. https://docs.google.com/spreadsheets/d/1QoXeB5RYw1HdPMY08eXgN7LIFKnNh9vESaDwbBL3lM8/edit#gid=0


Planifier les moissonneurs sur des plages de temps différentes.
eg. tous les jours à midi `0 0 12 * * ?`, 13h `0 0 13 * * ?`

Assigner un groupe et un utilisateur par défaut.
