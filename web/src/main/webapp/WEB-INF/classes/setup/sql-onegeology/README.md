# OneGeology migration to version 4

* Stop previous version
* Dump database
* Restore dump in new one (if needed)
* Apply [SQL migration script](migrate-4.1.0.sql)
* Start new version, sign in
* http://localhost:8080/geonetwork/doc/api/index.html#/tools/callStep and apply step `org.fao.geonet.MetadataResourceDatabaseMigration`
