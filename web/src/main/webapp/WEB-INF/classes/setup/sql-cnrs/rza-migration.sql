
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
DROP INDEX idx_metadatafiledownloads_metadataid;
DROP INDEX idx_metadatafileuploads_metadataid;
DROP INDEX idx_operationallowed_metadataid;

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
create sequence serviceparameter_id_seq;
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
SELECT setval('files_id_seq', (SELECT max(id) + 1 FROM files));
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



-- RZA clean up

-- Remove subtemplates
DELETE FROM metadata WHERE istemplate = 's';
DELETE FROM metadata WHERE istemplate = 't';
DELETE FROM metadata WHERE istemplate = 'y';

-- Clean up orphan operation
DELETE FROM operationallowed
    WHERE metadataid NOT IN (SELECT id FROM metadata);


UPDATE sources SET name = 'LTER France Metadata Node' WHERE type = 'portal';
UPDATE sourcesdes SET label = 'LTER France Metadata Node'
    WHERE iddes = (SELECT uuid FROM sources WHERE type = 'portal');

SELECT * FROM sources;
SELECT count(*) FROM metadata
    WHERE data LIKE '%resources.get%' AND isharvested = 'n';
