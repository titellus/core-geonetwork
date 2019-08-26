
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doienabled', 'false', 2, 191, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doiurl', '', 0, 192, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doiusername', '', 0, 193, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doipassword', '', 0, 194, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doikey', '', 0, 195, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/publication/doi/doilandingpagetemplate', 'http://localhost:8080/geonetwork/srv/resources/records/{{uuid}}', 0, 195, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('system/metadata/history/enabled', 'false', 2, 9171, 'n');

UPDATE StatusValues SET type = 'workflow';

UPDATE StatusValues SET notificationLevel = 'recordUserAuthor' WHERE name = 'approved';
UPDATE StatusValues SET notificationLevel = 'recordUserAuthor' WHERE name = 'retired';
UPDATE StatusValues SET notificationLevel = 'recordProfileReviewer' WHERE name = 'submitted';
UPDATE StatusValues SET notificationLevel = 'recordUserAuthor' WHERE name = 'rejected';


-- INSERT INTO StatusValues (id, name, reserved, displayorder, type, notificationLevel) VALUES  (100,'doiCreationTask','n', 100, 'task', 'statusUserOwner');


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

-- Update GML namespace for moving from ISO19139:2005 to ISO19139:2007
UPDATE Metadata SET data = replace(data, '"http://www.opengis.net/gml"', '"http://www.opengis.net/gml/3.2"') WHERE data LIKE '%"http://www.opengis.net/gml"%' AND schemaId = 'iso19139';

-- Unset 2005 schemaLocation
UPDATE Metadata SET data = replace(data, ' xsi:schemaLocation="http://www.isotc211.org/2005/gmd https://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx https://www.isotc211.org/2005/gmx/gmx.xsd http://www.isotc211.org/2005/srv http://schemas.opengis.net/iso/19139/20060504/srv/srv.xsd"', '') WHERE data LIKE '%xsi:schemaLocation="http://www.isotc211.org/2005/gmd https://www.isotc211.org/2005/gmd/gmd.xsd http://www.isotc211.org/2005/gmx https://www.isotc211.org/2005/gmx/gmx.xsd http://www.isotc211.org/2005/srv http://schemas.opengis.net/iso/19139/20060504/srv/srv.xsd%';

UPDATE metadata SET data = replace(data, '<gmd:version gco:nilReason="missing">', '<gmd:version gco:nilReason="unknown">') WHERE  data LIKE '%<gmd:version gco:nilReason="missing">%';

UPDATE Metadata SET data = replace(data, 'http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml', 'http://standards.iso.org/iso/19139/resources/gmxCodelists.xml') WHERE data LIKE '%http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml%' AND schemaId = 'iso19139';


DELETE FROM Settings WHERE name = 'ui/config';

ALTER TABLE Sources DROP islocal;

INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/coverPdf', 'https://geocatalogue.apur.org/catalogue/images/harvesting/apur/apur_pdf_cover.pdf', 0, 12500, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/introPdf', 'https://geocatalogue.apur.org/catalogue/images/harvesting/apur/apur_pdf_intro.pdf', 0, 12501, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/tocPage', 'false', 2, 12502, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/headerLeft', '{siteInfo}', 0, 12504, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/headerRight', '', 0, 12505, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/footerLeft', '', 0, 12506, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/footerRight', '{date}', 0, 12507, 'y');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/pdfReport/pdfName', 'metadata_{datetime}.pdf', 0, 12507, 'n');

UPDATE Settings SET internal='n' WHERE name='system/server/securePort';

UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/draftWhenInGroup';
UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/allowPublishInvalidMd';
UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/automaticUnpublishInvalidMd';
UPDATE Settings SET  position = position + 1 WHERE name = 'metadata/workflow/forceValidationOnMdSave';
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/workflow/enable', 'true', 2, 100002, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/workflow/allowSumitApproveInvalidMd', 'true', 2, 100004, 'n');
INSERT INTO Settings (name, value, datatype, position, internal) VALUES ('metadata/workflow/allowPublishNonApprovedMd', 'true', 2, 100005, 'n');


UPDATE Settings SET value='3.8.0' WHERE name='system/platform/version';
UPDATE Settings SET value='SNAPSHOT' WHERE name='system/platform/subVersion';
