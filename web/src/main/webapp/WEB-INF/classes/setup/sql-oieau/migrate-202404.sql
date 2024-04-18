

UPDATE Settings SET value='4.4.0' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'metadata/batchediting/accesslevel', 'Editor', 0, 12020, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'metadata/batchediting/accesslevel');


ALTER TABLE groups ALTER COLUMN name TYPE varchar(255);

UPDATE Settings SET value='4.4.1' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'metadata/pdfReport/headerLogoFileName', '', 0, 12508, 'y' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'metadata/pdfReport/headerLogoFileName');

UPDATE Settings SET value='4.4.2' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('region/getmap/useGeodesicExtents', 'false', 2, 9591, 'n');

DELETE FROM Settings WHERE name = 'system/index/indexingTimeRecordLink';


INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/documentation/url', 'https://docs.geonetwork-opensource.org/{{version}}/{{lang}}', 0, 570, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/userFeedback/metadata/enable', 'false', 2, 1913, 'n');


INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/translation/provider', '', 0, 7301, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/translation/serviceUrl', '', 0, 7302, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/translation/apiKey', '', 0, 7303, 'y');


UPDATE Settings SET value='4.4.3' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';


UPDATE Metadata SET data = replace(data, 'http://standards.iso.org/iso/19115/-3/srv/2.1', 'http://standards.iso.org/iso/19115/-3/srv/2.0') WHERE data LIKE '%http://standards.iso.org/iso/19115/-3/srv/2.1%' AND schemaId = 'iso19115-3.2018';

UPDATE Settings SET value='4.4.4' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';

UPDATE settings SET name='metadata/history/enabled' WHERE name='system/metadata/history/enabled';
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct 'metadata/history/accesslevel', 'Editor', 0, 12021, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'metadata/history/accesslevel');


UPDATE Settings SET value='4.4.5' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
