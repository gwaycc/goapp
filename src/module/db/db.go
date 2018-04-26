package db

import (
	_ "github.com/go-sql-driver/mysql"
	"github.com/gwaylib/conf"
	"github.com/gwaylib/database"
)

var dbFile = conf.RootDir() + "/etc/db.cfg"

func DB(section string) *database.DB {
	return database.CacheDB(dbFile, section)
}

func HasDB(section string) (*database.DB, error) {
	return database.HasDB(dbFile, section)
}
