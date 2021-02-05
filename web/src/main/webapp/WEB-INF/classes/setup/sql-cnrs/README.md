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
