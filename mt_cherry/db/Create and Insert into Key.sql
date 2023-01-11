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

INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("API KEY", "TBA user 1", "TBA", 0, "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("API KEY", "TBA user 2", "TBA", 0, "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("API KEY", "TBA user 3", "TBA", 0, "2099-01-01");
INSERT INTO "Key" (Key, Username, Description, Enabled, ExpireDate) VALUES ("API KEY", "TBA user 4", "TBA", 0, "2099-01-01");




