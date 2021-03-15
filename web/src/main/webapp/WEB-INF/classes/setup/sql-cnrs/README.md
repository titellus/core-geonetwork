# GeoNetwork RZA - Database migration

Current version (eg. 3.6.0):
```sql
SELECT value 
    FROM settings 
    WHERE name = 'system/platform/version';
```

Target version: 4.0.3.


The migration steps are:
* Create the new database (PostGIS is not needed)
* Import old database content
* Migrate the db structure and data using SQL script
* Start the application
* Migrate application using API calls


The migration will update metadata content with:
* Update to ISO19139:2007


# Restore current 3.6.0 database

Create the new database:
```sql
CREaTE DATABASE rza-catalogue OWNER gn;
```
Import old database content:
```shell script
psql -U gn -h localhost -f gndb.sql rza-catalogue
```

# SQL migration

Migrate the db structure and data using SQL script: See [rza-migration.sql](rza-migration.sql).

# Start the application


# Migrate application using API call

This step focus on:
* updating attachments link in metadata record to the new API (instead of using resource.get service, record attachments are now server by /api/records/{uuid}/attachments/{filename}).
* remove unused languages (only french and english are used). This simplify the user interface and improve a bit performances.

See [rza-migration.sh](rza-migration.sh).


# Thesaurus

Update of GEMET to version 4.1.2 from https://github.com/geonetwork/util-gemet/blob/master/thesauri/gemet.rdf.

Update INSPIRE thesaurus using the INSPIRE registry (see https://geonetwork-opensource.org/manuals/4.0.x/en/administrator-guide/configuring-the-catalog/inspire-configuration.html#loading-inspire-codelists):
* INSPIRE Theme
* Metadata codelist / Spatial scope
* Metadata codelist / Priority dataset


## EnvThes

To load the thesaurus in a GeoNetwork instance user needs to convert ttl format to XML skos:

```shell script
wget https://raw.githubusercontent.com/LTER-Europe/EnvThes/master/CurrentVersion/EnvThes.ttl
skosify EnvThes.ttl -o EnvThes.rdf
```

See https://pypi.org/project/skosify/ utility for the conversion.

## OZCAR-Theia thesaurus

https://github.com/NatLibFi/Skosmos/wiki/REST-API
https://in-situ.theia-land.fr/skosmos/rest/v1/theia_ozcar_thesaurus/

```shell script
curl https://in-situ.theia-land.fr/fuseki/theia_vocabulary/query -X POST --data 'query=%0APREFIX+skos%3A+%3Chttp%3A%2F%2Fwww.w3.org%2F2004%2F02%2Fskos%2Fcore%23%3E%0A%0A%0A%0ACONSTRUCT+%7B+%3Fs+%3Fp+%3Fo+%7D+WHERE+%7B+GRAPH+%3Chttps%3A%2F%2Fw3id.org%2Fozcar-theia%2F%3E+%7B+%3Fs+%3Fp+%3Fo+%7D+%7D' -H 'Accept: application/rdf+xml'
```

## Agrovoc

```shell script
wget http://agrovoc.uniroma2.it/agrovocReleases/agrovoc_2021-02-02_core.rdf.zip
```

Application is starting up but it does not look to be able to load 1Go thesaurus.

## Loterre - BHL

User can upload the thesaurus https://www.loterre.fr/wp-content/uploads/2020/04/Biodiversit%C3%A9.xml from the admin without issue.

## EUNIS-habitat

Format provided is CSV.

 
# Templates

**Des métadonnées pour quoi faire ?**

Objectifs: Définir les informations à renseigner pour répondre aux besoins de recherche, de tableaux de bords, de conformité vis à vis d'un standard/directives/normes/bonnes pratiques ... 


* Trouver des données - savoir qu'elles existent ? des services ? des cartes ?
  * Si oui, quels types de données ?
    * Données géo (et non géo - tabulaire ?)
    * Services WCS/WFS/WMS - avec liens 
    * Cartes PDF - Cartothèque
    * Série
  * Quel type de données géo ? eg. vecteur/raste
  * Des données dans quelles langues ? Francais, Anglais (langue principale) - Vidéo ?
 
* Les télécharger ? 
  * Si oui, quels formats ? 
  * quels serveur de données ? WMS/WFS - Vidéo ?
  * des services ? 
  * quelles projections ? Peut être toujours la même ? Libre ...
  * Accessible en interne/externe ? Lien web principalement, DOI 
  * eg. https://sdi.eea.europa.eu/catalogue/srv/eng/catalog.search#/metadata/b07cd829-47da-416c-83f5-9dc952191bfc
 
 
* Les classer comment ? par thèmes - thésaurus, par organisations, par contraintes d'accès, par fréquence de mise à jour, par date, par échelle, par capteurs ...
  * Quels sont les thésaurus obligatoire ?
  * eg. https://sextant.ifremer.fr/Donnees/Catalogue#/metadata/56062a3c-0234-48f3-b273-2db3bef7a17e 
  * eg. https://sextant.ifremer.fr/Donnees/Catalogue et un portail thématique https://www.odatis-ocean.fr/donnees-et-services/acces-aux-donnees/catalogue-complet#/search
  * eg. recherche temporelle https://galliwasp.eea.europa.eu/catalogue/srv/eng/catalog.search#/search
  

* Les décrire dans plusieurs langues ? ie. métadonnées multilingues
  * Si oui lesquelles ?
  
  
* Décrire les tables attributaires / modèles de données ?
  * eg. https://geocatalogue.apur.org/catalogue/srv/fre/catalog.search#/metadata/f2186409-8454-4fd5-8754-3f54ba3edd3f  

 
* Décrire la qualité des données ?
  * Généalogie,
  * Données source   
  * PNDB - Bien renseigné ?
  * voire même indicateurs eg. https://sextant.ifremer.fr/Donnees/Catalogue#/metadata/f8f7f98e-d31e-4a64-bf0c-f6db5cce3551
  * Contraintes d'accès ? Opendata


* Lier des données entre elles ?
  * Quel types de relation eg. série, données sources, service diffusant, ...
  * eg. https://sdi.eea.europa.eu/catalogue/srv/eng/catalog.search#/metadata/a3747af8-7581-430e-8d7f-9fbc5843545f (encodage manuel vs analyse de similarité), https://sextant.ifremer.fr/Donnees/Catalogue#/metadata/60ad1de2-c3e1-4d33-9468-c7f28d200305  


* Être conforme ? ISO ? INSPIRE ?
  * Valider avec https://inspire.ec.europa.eu/validator/
  * Eg. http://metawal.wallonie.be/geonetwork/srv/eng/catalog.search#/search?isTemplate=n&resourceTemporalDateRange=%7B%22range%22:%7B%22resourceTemporalDateRange%22:%7B%22gte%22:null,%22lte%22:null,%22relation%22:%22intersects%22%7D%7D%7D&sortBy=relevance&any=q(%2Btag:inspire)&from=1&to=30
  * Documentation https://geonetwork-opensource.org/manuals/4.0.x/en/user-guide/describing-information/inspire-editing.html


* Interagir avec des outils ?
  * Si oui, lesquels ? 
  * Geoflow, Visualiseur capteur, OGC WMS & carto
    * GeoFlow - Librairie R - CSV > métadonnées

  
* Besoin d'identifier avec DOI & Citation ? 
  * eg. https://sextant.ifremer.fr/Donnees/Catalogue#/metadata/56062a3c-0234-48f3-b273-2db3bef7a17e
  * Identifiant des données ?


* Relations entres les fiches
  * Données

# Thematic portals





# GeoNetwork improvements


## More robust indexing

While indexing 8997 records, a number of indexing errors occurred mainly due to invalid or unsupported records:

* XML containing a mix of ESRI and ISO19139 with various date formats http://meta.data-za.org/geonetwork/srv/api/records/cb3c14da-f355-4dc3-a1e7-6040d814d109/formatters/xml

* XML with invalid date `2015-14-12` http://meta.data-za.org/geonetwork/srv/api/records/fr-000029190-plu20131223/formatters/xml

* `8 juillet 1974`, `Premières mesures en 2004` (http://meta.data-za.org/geonetwork/srv/api/records/ce4ed271-cae4-4c99-b6be-63227eb6129f/formatters/xml), `22 juillet 2014 pour les enregistrement HOBO et 27 février 2014 pour les enregistrement Tiny tag` ....



* Dublin core / Multiple title / Only first one indexed (it will be better managed in DCAT2 plugin providing multilingual support).

* Invalid role value `{{role}}` trying to create an invalid field name.
```
GNIDX-XSL||Invalid element name. Invalid QName {{{role}}OrgForResource} (42)
```

* Multiple phones - only the first one is indexed
```
Error on line 1169 of index.xsl:
  XTTE0790: A sequence of more than one item is not allowed as the first argument of
  gn-fn-index:json-escape() ("02 38 42 24 55", "06 31 14 98 21") 
```

* Date parsing - more flexible with support for 20170322, 2015-10-18T19:59:30.2675269Z (nanoseconds) 
```
Error parsing ISO DateTimes '20170322'. Error is: Text '20170322' could not be parsed: Unable to obtain ZonedDateTime from TemporalAccessor: {},ISO resolved to 2017-03-22 of type java.time.format.Parsed
```

* Email / JSON character to escape. Only one email per contact is indexed. 
```
Parsing invalid JSON node { "organisation":"Direction régionale de l'environnement, de l'aménagement et du logement Centre-Val de Loire", "role":"owner", "email":"###Paramètre "adresse email" dans la fonction "Services INSPIRE"", "website":"", "logo":"", "individual":"", "position":"", "phone":"", "address":"" } for property contactForResource. Error is: Unexpected character ('a' (code 97)): was expecting comma to separate Object entries
 at [Source: (String)"{
```

Those issues are handled by https://github.com/geonetwork/core-geonetwork/pull/5398.


## GeoNetwork contributions

* More robust indexing https://github.com/geonetwork/core-geonetwork/pull/5398
