DROP TABLE IF EXISTS Key;

CREATE TABLE "Key" 
(
	"KeyID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
	"KeyTypeID" INTEGER NOT NULL,
	"Username" VARCHAR NOT NULL UNIQUE,
	"Key" VARCHAR NOT NULL UNIQUE,
	"Description" VARCHAR NOT NULL,
	"Enabled" BOOL NOT NULL DEFAULT (1),
	"ExpireDate" DATETIME NOT NULL,
	"CreateDate" DATETIME NOT NULL  DEFAULT (CURRENT_DATE),
	"ModifiedDate" DATETIME NOT NULL  DEFAULT (CURRENT_DATE),
	FOREIGN KEY(KeyTypeID) REFERENCES KeyType(KeyTypeID)
);

INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (1,"steve@lovoco.co","a89c01e7-1da2-488c-a1db-141dc70e1d60","Steve's Lovoco Admin Key",1,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (1,"stenopoly@webadmin","f0315821-2bbf-4bcc-8c22-b1a1d13b54ea","Stenopoly Web Admin",1,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"everyone@world","4ac85ecd-dc6d-49ee-a768-602ae2192ec9","Anyone can use this Key",1,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"z-centrix user","44d178bf-bcf9-499d-b419-01db66ef7e4c","Z-Centrix",1,"2027-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"TBA user 1","30f33f8a-27df-49ec-9d77-93b9a010eb61","TBA",0,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"TBA user 2","97f24c85-97ae-4bcb-80b9-78a9497ba40d","TBA",0,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"TBA user 3","d2875a97-1e0b-4fae-bc98-41676b521309","TBA",0,"2099-01-01");


INSERT INTO "someTable" VALUES ("1","2","TBA user 4","30f33f8a-27df-49ec-9d77-93b9a010eb61","TBA","0","2099-01-01","2017-09-24");
INSERT INTO "someTable" VALUES ("2","1","steve@lovoco.co","a89c01e7-1da2-488c-a1db-141dc70e1d60","Steve's Lovoco Admin Key","1","2099-01-01","2017-09-24");

INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (1,"steve@lovoco.co","a89c01e7-1da2-488c-a1db-141dc70e1d60","Steve's Lovoco Admin Key","1","2099-01-01");
