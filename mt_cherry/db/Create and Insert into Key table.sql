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

INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (1,"admin@you.com","API KEY","Steve's Lovoco Admin Key",1,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"everyone@world","API KEY","Anyone can use this Key",1,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"TBA user 1","API KEY","TBA",0,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"TBA user 2","API KEY","TBA",0,"2099-01-01");
INSERT INTO "Key"  (KeyTypeID, Username, Key, Description, Enabled, ExpireDate) VALUES (2,"TBA user 3","API KEY","TBA",0,"2099-01-01");
