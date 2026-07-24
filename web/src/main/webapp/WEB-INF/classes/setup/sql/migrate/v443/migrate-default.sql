INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct'system/documentation/url', 'https://docs.geonetwork-opensource.org/{{version}}/{{lang}}', 0, 570, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/documentation/url');
INSERT INTO Settings (name, value, datatype, position, internal) SELECT distinct'system/userFeedback/metadata/enable', 'false', 2, 1913, 'n' from settings WHERE NOT EXISTS (SELECT name FROM Settings WHERE name = 'system/userFeedback/metadata/enable');


INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/translation/provider', '', 0, 7301, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/translation/serviceUrl', '', 0, 7302, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/translation/apiKey', '', 0, 7303, 'y');


UPDATE Settings SET value='4.4.3' WHERE name='system/platform/version';
UPDATE Settings SET value='0' WHERE name='system/platform/subVersion';
