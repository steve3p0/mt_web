
--CREATE TABLE "Language" ("LanguageID" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , "Code" VARCHAR NOT NULL  UNIQUE , "Name" VARCHAR NOT NULL , "TextDirection" VARCHAR NOT NULL);
INSERT INTO Language (Code, Name, TextDirection) VALUES ("EN", "English", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("AR", "Arabic", "rtl");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("DE", "German", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("ES", "Spanish", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("FA", "Farsi", "rtl");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("FR", "French", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("HR", "Croatian", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("IT", "Italian", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("NL", "Dutch", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("PL", "Polish", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("PT", "Portuguese", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("RO", "Romanian", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("RU", "Russian", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("SL", "Slovenian", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("TR", "Turkish", "ltr");
INSERT INTO Language (Code, Name, TextDirection) VALUES ("ZH", "Chinese", "ltr");

--CREATE TABLE "LanguagePair" ("LanguagePairID" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , "Enabled" BOOL NOT NULL , "SourceLanguageID" INTEGER NOT NULL , "TargetLanguageID" INTEGER NOT NULL, "Port" INTEGER NOT NULL, "CreateDate" DATETIME NOT NULL  DEFAULT (CURRENT_DATE) ,"ModifiedDate" DATETIME NOT NULL  DEFAULT (CURRENT_DATE) );
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 2, 3014);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 3, 3002);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 4, 3003);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 5, 3015);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 6, 3004);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 7, 3012);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 8, 3005);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 9, 3006);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 10, 3007);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 11, 3008);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 12, 3009);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 13, 3010);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 14, 3011);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 15, 3013);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 1, 16, 3001);

INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 2, 1, 4014);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 3, 1, 4002);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 4, 1, 4003);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 5, 1, 4015);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 6, 1, 4004);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 7, 1, 4012);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 8, 1, 4005);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 9, 1, 4006);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 10, 1, 4007);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 11, 1, 4008);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 12, 1, 4009);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 13, 1, 4010);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 14, 1, 4011);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 15, 1, 4013);
INSERT INTO LanguagePair (Enabled, SourceLanguageID, TargetLanguageID, Port) VALUES (1, 16, 1, 4001);


-- CREATE TABLE "Key" ("KeyID" INTEGER PRIMARY KEY  NOT NULL  DEFAULT (null) ,"Key" VARCHAR NOT NULL ,"Description" VARCHAR NOT NULL ,"Enabled" BOOL NOT NULL ,"ExpireDate" DATETIME NOT NULL ,"CreateDate" DATETIME NOT NULL  DEFAULT (CURRENT_DATE) ,"ModifiedDate" DATETIME NOT NULL  DEFAULT (CURRENT_DATE) );
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("4ac85ecd-dc6d-49ee-a768-602ae2192ec9", "Lovoco Internal Key", 1, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("069e4d60-3fa9-4a07-9763-0ce599fda8f9", "Lovoco Internal Key #1", 1, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("f0315821-2bbf-4bcc-8c22-b1a1d13b54ea", "Lovoco Internal Key #2", 1, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("282ee77e-ebc5-4081-b891-8ee85151b9ce", "Lovoco Internal Key #3", 1, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("b26d0faf-d022-476f-b108-981f5a9cb081", "Lovoco Internal Key #4", 1, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("44d178bf-bcf9-499d-b419-01db66ef7e4c", "Z-Centrix", 1, '2027-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("a89c01e7-1da2-488c-a1db-141dc70e1d60", "TBA", 0, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("97f24c85-97ae-4bcb-80b9-78a9497ba40d", "TBA", 0, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("d2875a97-1e0b-4fae-bc98-41676b521309", "TBA", 0, '2099-01-01');
INSERT INTO Key (Key, Description, Enabled, ExpireDate) VALUES ("30f33f8a-27df-49ec-9d77-93b9a010eb61", "TBA", 0, '2099-01-01');

SELECT lp.Port 
   FROM LanguagePair lp
INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID
INNER JOIN Language tl ON lp.TargetLanguageID = tl.LanguageID
WHERE Enabled = 1 
AND sl.CODE = 'EN'
AND tl.CODE = 'FR'

SELECT lp.Port FROM LanguagePair lp
INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID
INNER JOIN Language tl ON lp.TargetLanguageID = tl.LanguageID
WHERE Enabled = 1 AND sl.CODE = 'EN' AND tl.CODE = 'FR'
