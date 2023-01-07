--DROP TABLE IF EXISTS Key;

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

INSERT INTO "Key" (Key, Username, Description, ExpireDate) VALUES ("4ac85ecd-dc6d-49ee-a768-602ae2192ec9", "steve@lovoco.co #1", "Lovoco Key #1", "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, ExpireDate) VALUES ("069e4d60-3fa9-4a07-9763-0ce599fda8f9", "steve@lovoco.co #2", "Lovoco Кey #2", "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, ExpireDate) VALUES ("f0315821-2bbf-4bcc-8c22-b1a1d13b54ea", "steve@lovoco.co #3", "Lovoco Key #3", "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, ExpireDate) VALUES ("282ee77e-ebc5-4081-b891-8ee85151b9ce", "steve@lovoco.co #4", "Lovoco Key #4", "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, ExpireDate) VALUES ("b26d0faf-d022-476f-b108-981f5a9cb081", "steve@lovoco.co #5", "Lovoco Key #5", "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, ExpireDate) VALUES ("44d178bf-bcf9-499d-b419-01db66ef7e4c", "z-centrix user", "Z-Centrix", "2027-01-01");
INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("a89c01e7-1da2-488c-a1db-141dc70e1d60", "TBA user 1", "TBA", 0, "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("97f24c85-97ae-4bcb-80b9-78a9497ba40d", "TBA user 2", "TBA", 0, "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("d2875a97-1e0b-4fae-bc98-41676b521309", "TBA user 3", "TBA", 0, "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("30f33f8a-27df-49ec-9d77-93b9a010eb61", "TBA user 4", "TBA", 0, "2099-01-01");




