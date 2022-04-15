-- SELECT * FROM settings WHERE name LIKE '%version%'
-- 3.4.2



-- 3.5.0 https://github.com/geonetwork/core-geonetwork/blob/master/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v350/migrate-default.sql


INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doienabled', 'false', 2, 191, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doiurl', '', 0, 192, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doiusername', '', 0, 193, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doipassword', '', 0, 194, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doikey', '', 0, 195, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doilandingpagetemplate', 'http://localhost:8080/geonetwork/srv/resources/records/{{uuid}}', 0, 195, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadata/history/enabled', 'false', 2, 9171, 'n');

ALTER TABLE StatusValues ADD COLUMN  type              varchar(255);

UPDATE StatusValues SET type = 'workflow';
ALTER TABLE StatusValues ADD COLUMN notificationlevel              varchar(255);

UPDATE StatusValues SET notificationLevel = 'recordUserAuthor' WHERE name = 'approved';
UPDATE StatusValues SET notificationLevel = 'recordUserAuthor' WHERE name = 'retired';
UPDATE StatusValues SET notificationLevel = 'recordProfileReviewer' WHERE name = 'submitted';
UPDATE StatusValues SET notificationLevel = 'recordUserAuthor' WHERE name = 'rejected';



INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (100,'doiCreationTask','n', 100, 'task', 'statusUserOwner');


INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (50,'recordcreated','y', 50, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (51,'recordupdated','y', 51, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (52,'attachmentadded','y', 52, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (53,'attachmentdeleted','y', 53, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (54,'recordownerchange','y', 54, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (55,'recordgroupownerchange','y', 55, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (56,'recordprivilegeschange','y', 56, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (57,'recordcategorychange','y', 57, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (58,'recordvalidationtriggered','y', 58, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (59,'recordstatuschange','y', 59, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (60,'recordprocessingchange','y', 60, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (61,'recorddeleted','y', 61, 'event', null);
INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (62,'recordimported','y', 62, 'event', null);

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/vcs/enable', 'false', 2, 9161, 'n');

UPDATE Schematron SET filename = 'schematron-rules-url-check.xsl' WHERE filename = 'schematron-rules-url-check.report_only.xsl';
UPDATE Schematron SET filename = 'schematron-rules-inspire-sds.xsl' WHERE filename = 'schematron-rules-inspire-sds.disabled.xsl';
UPDATE Schematron SET filename = 'schematron-rules-inspire-strict.xsl' WHERE filename = 'schematron-rules-inspire-strict.disabled.xsl';
UPDATE Schematron SET filename = 'schematron-rules-inspire.xsl' WHERE filename = 'schematron-rules-inspire-disabled.xsl';


-- INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (0,'fre','Inconnu');
-- INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (1,'fre','Brouillon');
-- INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (2,'fre','Validé');
-- INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (3,'fre','Retiré');
-- INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (4,'fre','A valider');
-- INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (5,'fre','Rejeté');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (50,'fre','Fiche créée.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (51,'fre','Fiche mise à jour.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (52,'fre','Document {{h.item1}} ajouté.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (53,'fre','Document {{h.item1}} supprimé.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (54,'fre','Auteur {{h.item1}} remplacé par {{h.item2}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (55,'fre','Groupe {{h.item1}} remplacé par {{h.item2}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (56,'fre','Accès mis à jour.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (57,'fre','Changement de catégorie. Les catégories sont {{h.item1}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (58,'fre','Fiche validée. La validation est maintenant {{h.item1}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (59,'fre','Changement de status de {{h.item1}} à {{h.item2}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (60,'fre','Fiche mise à jour par le processus {{h.item1}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (61,'fre','Fiche supprimée.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (62,'fre','Fiche importée.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (100,'fre','Demande de création de DOI');


INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (50,'eng','Record created.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (51,'eng','Record updated.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (52,'eng','Attachment {{h.currentStatus}} added.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (53,'eng','Attachment {{h.previousStatus}} deleted.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (54,'eng','Owner changed from {{h.previousStatus}} to {{h.currentStatus}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (55,'eng','Group owner changed from {{h.previousStatus}} to {{h.currentStatus}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (56,'eng','Privileges updated.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (57,'eng','Category changed. Now categories are {{h.currentStatus}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (58,'eng','Validation triggered. Exit status is now {{h.currentStatus}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (59,'eng','Status changed from {{h.previousStatus}} to {{h.currentStatus}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (60,'eng','Record updated by process {{h.currentStatus}}.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (61,'eng','Record deleted.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (62,'eng','Record imported.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (100,'eng','DOI creation request');



-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v370/migrate-default.sql

DELETE FROM Settings WHERE name = 'ui/config';

ALTER TABLE Sources DROP COLUMN islocal;

UPDATE Metadata SET data = replace(data, 'http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml', 'http://standards.iso.org/iso/19139/resources/gmxCodelists.xml') WHERE data LIKE '%http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml%' AND schemaId = 'iso19139';

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/coverPdf', '', 0, 12500, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/introPdf', '', 0, 12501, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/tocPage', 'false', 2, 12502, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/headerLeft', '{siteInfo}', 0, 12504, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/headerRight', '', 0, 12505, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/footerLeft', '', 0, 12506, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/footerRight', '{date}', 0, 12507, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/pdfName', 'metadata_{datetime}.pdf', 0, 12507, 'n');

-- Update GML namespace for moving from ISO19139:2005 to ISO19139:2007
UPDATE Metadata SET data = replace(data, '"http://www.opengis.net/gml"', '"http://www.opengis.net/gml/3.2"') WHERE data LIKE '%"http://www.opengis.net/gml"%' AND schemaId = 'iso19139';

-- Unset 2005 schemaLocation
UPDATE Metadata SET data = replace(data, ' xsi:schemaLocation="http://www.isotc211.org/2005/gmd https://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx https://www.isotc211.org/2005/gmx/gmx.xsd http://www.isotc211.org/2005/srv http://schemas.opengis.net/iso/19139/20060504/srv/srv.xsd"', '') WHERE data LIKE '%xsi:schemaLocation="http://www.isotc211.org/2005/gmd https://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx https://www.isotc211.org/2005/gmx/gmx.xsd http://www.isotc211.org/2005/srv http://schemas.opengis.net/iso/19139/20060504/srv/srv.xsd%';

UPDATE Settings SET internal='n' WHERE name='system/server/securePort';


UPDATE metadata SET data = replace(data, '<gmd:version gco:nilReason="missing">', '<gmd:version gco:nilReason="unknown">') WHERE  data LIKE '%<gmd:version gco:nilReason="missing">%';


UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/draftWhenInGroup';
UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/allowPublishInvalidMd';
UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/automaticUnpublishInvalidMd';
UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/forceValidationOnMdSave';
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/workflow/enable', 'true', 2, 100002, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/workflow/allowSumitApproveInvalidMd', 'true', 2, 100004, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/workflow/allowPublishNonApprovedMd', 'true', 2, 100005, 'n');


DROP TABLE ServiceParameters;
DROP TABLE Services;

UPDATE Settings SET value='3.7.0' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v381/migrate-default.sql
UPDATE Settings SET value='3.8.1' WHERE name='system/platform/version';






-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v382/migrate-default.sql


ALTER TABLE sources ADD COLUMN creationdate varchar(30);
ALTER TABLE sources ADD COLUMN filter varchar(255);
ALTER TABLE sources ADD COLUMN groupowner integer;
ALTER TABLE sources ADD COLUMN logo varchar(255);
ALTER TABLE sources ADD COLUMN servicerecord varchar(255);
ALTER TABLE sources ADD COLUMN type varchar(255);
ALTER TABLE sources ADD COLUMN uiconfig varchar(255);


UPDATE Sources SET type = 'portal' WHERE type IS null AND uuid = (SELECT value FROM settings WHERE name = 'system/site/siteId');
UPDATE Sources SET type = 'harvester' WHERE type IS null AND uuid != (SELECT value FROM settings WHERE name = 'system/site/siteId');

UPDATE Settings SET internal = 'y' WHERE name = 'system/publication/doi/doipassword';

UPDATE Settings SET value='3.8.2' WHERE name='system/platform/version';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v383/migrate-default.sql
UPDATE Settings SET value='3.8.3' WHERE name='system/platform/version';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v390/migrate-default.sql
UPDATE Settings SET value='3.9.0' WHERE name='system/platform/version';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v3101/migrate-default.sql
DELETE FROM cswservercapabilitiesinfo;
DELETE FROM Settings WHERE name = 'system/csw/contactId';
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/csw/capabilityRecordUuid', '-1', 0, 1220, 'y');

UPDATE Settings SET value='3.10.1' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v3102/migrate-default.sql
UPDATE Settings SET value='3.10.2' WHERE name='system/platform/version';




-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v3103/migrate-default.sql
ALTER TABLE groupsdes ALTER COLUMN label TYPE varchar(255);
ALTER TABLE sourcesdes ALTER COLUMN label TYPE varchar(255);
ALTER TABLE schematrondes ALTER COLUMN label TYPE varchar(255);

-- New setting for server timezone
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/server/timeZone', '', 0, 260, 'n');

-- keep these at the bottom of the file!
-- DROP INDEX idx_metadatafiledownloads_metadataid;
-- DROP INDEX idx_metadatafileuploads_metadataid;
-- DROP INDEX idx_operationallowed_metadataid;

UPDATE Settings SET value='3.10.3' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v3104/migrate-default.sql
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/users/identicon', 'gravatar:mp', 0, 9110, 'n');

UPDATE Settings SET value='3.10.4' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v3110/migrate-default.sql
-- Increase the length of Validation type (where the schematron file name is stored)
ALTER TABLE Validation ALTER COLUMN valType TYPE varchar(128);


create table if not exists usersearch
(
  id integer not null
  constraint usersearch_pkey
  primary key,
  creationdate timestamp,
  featuredtype char,
  logo varchar(255),
  url text,
  creator_id integer
  constraint fk_8t1fpen9991fcym0estudh2cf
  references users
  constraint fkelx0lms0v5rv3xlvamxtbb4ar
  references users
  );
-- ALTER TABLE usersearch ALTER COLUMN url TYPE text;

INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (63,'recordrestored','y', 63, 'event', null);
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (63,'eng','Record restored.');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (63,'fre','Fiche restaurée.');

UPDATE Settings SET value='3.11.0' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';




-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v400/migrate-default.sql
DROP TABLE metadatanotifications;
DROP TABLE metadatanotifiers;

DELETE FROM Settings WHERE name LIKE 'system/indexoptimizer%';
DELETE FROM Settings WHERE name LIKE 'system/requestedLanguage%';
DELETE FROM Settings WHERE name = 'system/inspire/enableSearchPanel';
DELETE FROM Settings WHERE name = 'system/autodetect/enable';

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/index/indexingTimeRecordLink', 'false', 2, 9209, 'n');

UPDATE metadata
SET data = REGEXP_REPLACE(data, '[a-z]{3}\/thesaurus\.download\?ref=', 'api/registries/vocabularies/', 'g')
WHERE data LIKE '%thesaurus.download?ref=%';

UPDATE settings SET value = '1' WHERE name = 'system/threadedindexing/maxthreads';



create table if not exists links
(
  id integer not null
  constraint links_pkey
  primary key,
  laststate integer,
  linktype varchar(255) not null,
  protocol varchar(255),
  url text
  constraint uk_fwi9l3n3vcxonf7c3x1ntdivx
  unique,
  dateandtime varchar(255)
  );


create table if not exists linkstatus
(
  id integer not null
  constraint linkstatus_pkey
  primary key,
  batchkey varchar(255),
  checkdate varchar(30),
  failing char default 'y'::bpchar not null,
  statusinfo text,
  statusvalue varchar(255) not null,
  link integer not null
  constraint fk_kq0np8v1ceeghuing8965fpa4
  references links
  constraint fkp5kjknw6whjr91s4h9xtadgv6
  references links
  );

create index if not exists idx_linkstatus_isfailing
  on linkstatus (failing);





-- Utility script to update sequence to current value on Postgres
-- https://github.com/geonetwork/core-geonetwork/pull/5003
-- create sequence serviceparameter_id_seq;
create sequence address_id_seq;
create sequence csw_server_capabilities_info_id_seq;
create sequence files_id_seq;
create sequence group_id_seq;
create sequence gufkey_id_seq;
create sequence gufrat_id_seq;
create sequence harvest_history_id_seq;
create sequence harvester_setting_id_seq;
create sequence inspire_atom_feed_id_seq;
create sequence iso_language_id_seq;
create sequence link_id_seq;
create sequence linkstatus_id_seq;
create sequence mapserver_id_seq;
create sequence metadata_category_id_seq;
create sequence metadata_filedownload_id_seq;
create sequence metadata_fileupload_id_seq;
create sequence metadata_id_seq;
create sequence metadata_identifier_template_id_seq;
create sequence operation_id_seq;
create sequence rating_criteria_id_seq;
create sequence schematron_criteria_id_seq;
create sequence schematron_id_seq;
create sequence selection_id_seq;
create sequence status_value_id_seq;
create sequence user_id_seq;
create sequence user_search_id_seq;
create sequence messageproducerentity_id_seq;
create sequence annotation_id_seq;
create sequence message_producer_entity_id_seq;
create sequence metadatastatus_id_seq;

SELECT setval('address_id_seq', (SELECT max(id) + 1 FROM address));
SELECT setval('csw_server_capabilities_info_id_seq', (SELECT max(idfield) FROM cswservercapabilitiesinfo));
-- SELECT setval('files_id_seq', (SELECT max(id) + 1 FROM files));
SELECT setval('group_id_seq', (SELECT max(id) + 1 FROM groups));
SELECT setval('gufkey_id_seq', (SELECT max(id) + 1 FROM guf_keywords));
SELECT setval('gufrat_id_seq', (SELECT max(id) + 1 FROM guf_rating));
SELECT setval('harvest_history_id_seq', (SELECT max(id) + 1 FROM harvesthistory));
SELECT setval('harvester_setting_id_seq', (SELECT max(id) + 1 FROM harvestersettings));
SELECT setval('inspire_atom_feed_id_seq', (SELECT max(id) + 1 FROM inspireatomfeed));
SELECT setval('iso_language_id_seq', (SELECT max(id) + 1 FROM isolanguages));
SELECT setval('link_id_seq', (SELECT max(id) + 1 FROM links));
SELECT setval('linkstatus_id_seq', (SELECT max(id) + 1 FROM linkstatus));
SELECT setval('mapserver_id_seq', (SELECT max(id) + 1 FROM mapservers));
SELECT setval('metadata_category_id_seq', (SELECT max(id) + 1 FROM categories));
SELECT setval('metadata_filedownload_id_seq', (SELECT max(id) + 1 FROM metadatafiledownloads));
SELECT setval('metadata_fileupload_id_seq', (SELECT max(id) + 1 FROM metadatafileuploads));
SELECT setval('metadata_id_seq', (SELECT max(id) + 1 FROM metadata));
SELECT setval('metadata_identifier_template_id_seq', (SELECT max(id) + 1 FROM metadataidentifiertemplate));
SELECT setval('operation_id_seq', (SELECT max(id) + 1 FROM operations));
SELECT setval('rating_criteria_id_seq', (SELECT max(id) + 1 FROM guf_ratingcriteria));
SELECT setval('schematron_criteria_id_seq', (SELECT max(id) + 1 FROM schematroncriteria));
SELECT setval('schematron_id_seq', (SELECT max(id) + 1 FROM schematron));
SELECT setval('selection_id_seq', (SELECT max(id) + 1 FROM selections));
SELECT setval('status_value_id_seq', (SELECT max(id) + 1 FROM statusvalues));
SELECT setval('user_id_seq', (SELECT max(id) + 1 FROM users));
SELECT setval('user_search_id_seq', (SELECT max(id) + 1 FROM usersearch));

UPDATE Settings SET value='4.0.0' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v401/migrate-default.sql
UPDATE Settings SET value='4.0.1' WHERE name='system/platform/version';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v402/migrate-default.sql
UPDATE Settings SET value = 'Europe/Paris' WHERE name = 'system/server/timeZone' AND VALUE = '';

ALTER TABLE guf_userfeedbacks_guf_rating DROP COLUMN GUF_UserFeedbacks_uuid;

UPDATE Settings SET value='4.0.2' WHERE name='system/platform/version';


-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v403/migrate-default.sql

DROP TABLE metadatastatus;

UPDATE Settings SET value='4.0.3' WHERE name='system/platform/version';





-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v404/migrate-default.sql

DELETE FROM Schematrondes WHERE iddes IN (SELECT id FROM schematron WHERE filename LIKE 'schematron-rules-inspire%');
DELETE FROM Schematroncriteria WHERE group_name || group_schematronid IN (SELECT name || schematronid FROM schematroncriteriagroup WHERE schematronid IN (SELECT id FROM schematron WHERE filename LIKE 'schematron-rules-inspire%'));
DELETE FROM Schematroncriteriagroup WHERE schematronid IN (SELECT id FROM schematron WHERE filename LIKE 'schematron-rules-inspire%');
DELETE FROM Schematron WHERE filename LIKE 'schematron-rules-inspire%';


UPDATE Settings SET value='4.0.4' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';

-- ALTER TABLE Settings ADD COLUMN encrypted VARCHAR(1) DEFAULT 'n';
-- UPDATE Settings SET encrypted='y' WHERE name='system/proxy/password';
-- UPDATE Settings SET encrypted='y' WHERE name='system/feedback/mailServer/password';
-- UPDATE Settings SET encrypted='y' WHERE name='system/publication/doi/doipassword';

-- https://github.com/geonetwork/core-geonetwork/blob/4.0.x/web/src/main/webapp/WEB-INF/classes/setup/sql/migrate/v405/migrate-default.sql

UPDATE metadata SET data = replace(data, 'WWW:DOWNLOAD-OGC:OWS-C', 'OGC:OWS-C') WHERE data LIKE '%WWW:DOWNLOAD-OGC:OWS-C%';


UPDATE Settings SET internal = 'n' WHERE name = 'system/metadata/prefergrouplogo';

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/inspire/remotevalidation/nodeid', '', 0, 7212, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/inspire/remotevalidation/apikey', '', 0, 7213, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doipublicurl', '', 0, 100196, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/harvester/enablePrivilegesManagement', 'false', 2, 9010, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/localrating/notificationLevel', 'catalogueAdministrator', 0, 2111, 'n');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadatacreate/preferredGroup', '', 1, 9105, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadatacreate/preferredTemplate', '', 0, 9106, 'n');

DELETE FROM Settings WHERE name = 'system/server/securePort';

INSERT INTO Users (id, username, password, name, surname, profile, kind, organisation, security, authtype, isenabled) VALUES  (0,'nobody','','nobody','nobody',4,'','','','', 'n');
INSERT INTO Address (id, address, city, country, state, zip) VALUES  (0, '', '', '', '', '');
INSERT INTO UserAddress (userid, addressid) VALUES  (0, 0);



UPDATE Settings SET value='4.1.0' WHERE name='system/platform/version';
UPDATE Settings SET value='+' WHERE name='system/platform/subVersion';



INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/security/passwordEnforcement/minLength', '6', 1, 12000, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/security/passwordEnforcement/maxLength', '20', 1, 12001, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/security/passwordEnforcement/usePattern', 'true', 2, 12002, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/security/passwordEnforcement/pattern', '^((?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*(_|[^\w])).*)$', 0, 12003, 'n');


INSERT INTO MetadataIdentifierTemplate (id, name, template, isprovided) VALUES  (0, 'Custom URN', ' ', 'y');
INSERT INTO MetadataIdentifierTemplate (id, name, template, isprovided) VALUES  (1, 'Autogenerated URN', ' ', 'y');

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadatacreate/generateUuid', 'true', 2, 9100, 'n');

-- ###############
-- 1GG cleanup
-- ###############
-- If testing on another DB, need to change the URLs
-- UPDATE metadata SET data = replace(data,
--   'http://onegeology-geonetwork.brgm.fr/geonetwork3',
--   'http://localhost:8080/geonetwork')
--   WHERE data LIKE '%http://onegeology-geonetwork.brgm.fr/geonetwork3%';


DELETE FROM operationallowed WHERE metadataid in (SELECT id FROM Metadata WHERE schemaid = 'fgdc-std');
DELETE FROM Metadata WHERE schemaid = 'fgdc-std';



-- Invalid operatesOn : xlink is relative and UUID does not exist?
-- eg. http://onegeology-geonetwork.brgm.fr/geonetwork3/srv/api/records/50b5175e6544ab368c3e1759b13949242f41865/formatters/xml
-- <srv:operatesOn uuidref="c3ecb40e-1c0d-43dd-bb9b-15bf261e179b"
--                 xlink:href="/geonetwork/srv/en/metadata.show?id=3121"/>
--
--  15 records
-- e11a18cf6b621a74d4e213c3de7423cc2f933b
-- dceaf4f58a29f0efdd1952764910191190fa5f
-- d180cb9fbcdb5e39154b56feb21adfd9e07c5c
-- b13949d8b1ebb1e161a4758b8c2c565701a5823
-- a5b3b127f353917a29912edb8ff4a8da5820b8
-- 9dfbff24e94866cf7f72df25873a3251a448aef2
-- 7046553b5dcfb7cae2c28b2af21b5af4b9a2ab46
-- 66ead979cad23ede7ec325f0643ae2e8d3871d5b
-- 5a3bf860a193daa72ae9ac294b8ea37f9aa2a573
-- 5613593a-f792-47a6-8dea-6e3bd229f2b4
-- 50b5175e6544ab368c3e1759b13949242f41865
-- 44a652e5821cd8dbe82616638a1b7c29a0b48ce3
-- 2d5daf9be05a6f2930eff78d24c0aeb82ee37171
-- 2a641ac374277f7b6ef68083d9d7b151302297dc
-- 1b91b3c5c2b582b7f4282b4f3374aa4c27f144db


UPDATE metadata SET data = REGEXP_REPLACE(data, ' xlink:href="\/geonetwork\/srv\/en\/metadata\.show\?id=[0-9]+"', '', 'g') WHERE data LIKE '%xlink:href="/geonetwork/srv/en/metadata.show%';

-- Identifier / Should we update them ? Those URLs still exist.
-- gmd:identifier>
-- <gmd:MD_Identifier>
-- <gmd:code>
-- <gco:CharacterString>onegeology-geonetwork.brgm.fr/geonetwork3/srv/metadata/50b5175e6544ab368c3e1759b13949242f41865</gco:CharacterString>
-- </gmd:code>





-- ## Les cas
-- http://http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/eng//xml.metadata.get?uuid=
-- <srv:operatesOn uuidref="f4b7a016e0b8d9357c67487de6c9f4f7a1a7087a" xlink:href="http://http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/eng//xml.metadata.get?uuid=f4b7a016e0b8d9357c67487de6c9f4f7a1a7087a"/>
UPDATE metadata SET data = replace(data,
                                   'http://http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/eng//xml.metadata.get?uuid=',
                                   'http://onegeology-geonetwork.brgm.fr/geonetwork3/srv/api/records/')
WHERE data LIKE '%http://http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/eng//xml.metadata.get?uuid=%';

-- <gmd:MD_BrowseGraphic>
-- <gmd:fileName>
-- <gco:CharacterString>http://http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/fre/resources.get?uuid=2b680d6c-df90-430e-afc4-dfc8a4e017ef&fname=2b680d6c-df90-430e-afc4-dfc8a4e017ef_s.png</gco:CharacterString>

UPDATE metadata SET data = replace(data,
                                   '&amp;fname=',
                                   '/attachments/')
WHERE data LIKE '%&amp;fname=%';

UPDATE metadata SET data = replace(data,
                                   '>http://http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/fre/resources.get?uuid=',
                                   '>http://onegeology-geonetwork.brgm.fr/geonetwork3/srv/api/records/')
WHERE data LIKE '%>http://http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/fre/resources.get?uuid=%';

UPDATE metadata SET data = replace(data,
                                   '>http://onegeology-geonetwork.brgm.fr/geonetwork3/srv/eng/resources.get?uuid=',
                                   '>http://onegeology-geonetwork.brgm.fr/geonetwork3/srv/api/records/')
WHERE data LIKE '%>http://onegeology-geonetwork.brgm.fr/geonetwork3/srv/eng/resources.get?uuid=%';

UPDATE metadata SET data = replace(data,
                                   '>http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/fre/resources.get?uuid=',
                                   '>http://onegeology-geonetwork.brgm.fr/geonetwork3/srv/api/records/')
WHERE data LIKE '%>http://onegeology-catalog.brgm-rec.fr/geonetwork3/srv/fre/resources.get?uuid=%';



