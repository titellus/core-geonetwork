UPDATE Metadata
    SET data = replace(data,
        '111 avenue de France', '15 rue Jean-Baptiste Berlier')
     WHERE data LIKE '%111 avenue de France%';

UPDATE Metadata
    SET data = replace(data,
        'emmanuel.faure@apur.org', 'data@apur.org')
     WHERE data LIKE '%emmanuel.faure@apur.org%';

