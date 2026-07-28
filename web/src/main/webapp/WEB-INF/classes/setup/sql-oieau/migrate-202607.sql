INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/userSelfRegistration/domainsAllowed', '', 0, 1911, 'y' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/userSelfRegistration/domainsAllowed');

UPDATE Settings SET value='4.4.6' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/banner/enable', 'false', 2, 1920, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/banner/enable');
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/auditable/enable', 'false', 2, 12010, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/auditable/enable');

UPDATE Settings SET value='4.4.7' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'metadata/delete/backupOptions', 'UseAPIParameter', 0, 12012, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'metadata/delete/backupOptions');

UPDATE Settings SET value='4.4.8' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/publication/doi/doimailnotification', 'false', 2, 100192, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/publication/doi/doimailnotification');

-- Migration to 4.4.5 only removed the old DOI settings, when the DOI server was defined.
-- Related to https://github.com/geonetwork/core-geonetwork/pull/8098
DELETE FROM Settings WHERE name LIKE 'system/publication/doi%' and name != 'system/publication/doi/doienabled';

UPDATE Settings SET value='4.4.9' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/metadatacreate/publishForGroupEditors', 'false', 2, 9101, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/metadatacreate/publishForGroupEditors');
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/metadatacreate/copyAttachments', 'true', 2, 9102, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/metadatacreate/copyAttachments');
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/metadatacreate/skipMetadataCreationPage', 'false', 2, 9103, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/metadatacreate/skipMetadataCreationPage');

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/metadata/edit/supportedFileMimetypes', 'image/png|image/gif|image/jpeg|text/plain|application/xml|application/pdf', 0, 9107, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/metadata/edit/supportedFileMimetypes');

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'metadata/zipExport/attachmentsSizeLimit', NULL, 1, 12700, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'metadata/zipExport/attachmentsSizeLimit');

ALTER TABLE groups ADD type VARCHAR(255);

UPDATE groups SET type='RecordPrivilege' WHERE id<2 AND type IS NULL;
UPDATE groups SET type='Workspace' WHERE id>=2 AND type IS NULL;

UPDATE Settings SET value='4.4.10' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

UPDATE settings_ui
SET configuration = replace(
  configuration,
  '"gn-recordview-manage-menu"',
  '"gn-recordview-manage-menu","gn-recordview-download-menu"'
                    )
WHERE configuration LIKE '%"gn-recordview-manage-menu"%'
  AND configuration NOT LIKE '%"gn-recordview-download-menu"%';

UPDATE Settings SET value='4.4.11' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';


INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/csw/getRecordsIgnoreMetadataNotSupported', 'true', 2, 1321, 'y');

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'system/oai/enable', 'true', 2, 7000, 'n'  from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/oai/enable');

DROP SEQUENCE IF EXISTS files_id_seq;
DROP TABLE IF EXISTS files;

UPDATE Settings SET value='4.4.12' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';


ALTER TABLE spg_page ADD COLUMN IF NOT EXISTS showOnNonApproved boolean DEFAULT true NOT NULL;
ALTER TABLE spg_page ADD COLUMN IF NOT EXISTS showOnApproved boolean DEFAULT true NOT NULL;
ALTER TABLE spg_page ADD COLUMN IF NOT EXISTS showWhenWorkflowDisabled boolean DEFAULT true NOT NULL;

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/publication/enableScheduledPublication', 'false', 2, 12023, 'n');

INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (101,'scheduledPublicationTask','n', 101, 'task', 'statusUserOwner');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'ara','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'arm','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'aze','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'cat','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'chi','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'dan','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'dut','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'eng','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'fin','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'fre','Publication programmée');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'geo','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'ger','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'ita','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'nor','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'pol','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'por','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'rum','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'rus','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'slo','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'spa','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'swe','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'tur','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'ukr','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'vie','Scheduled publication');
INSERT INTO StatusValuesDes  (iddes, langid, label) VALUES (101,'wel','Scheduled publication');


UPDATE Settings SET value='4.4.13' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';


UPDATE Settings SET editable = 'y' WHERE editable IS NULL;
UPDATE Settings SET value = '' WHERE value IS NULL;
