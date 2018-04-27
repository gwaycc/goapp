package db

import (
	_ "github.com/go-sql-driver/mysql"
	"github.com/gwaylib/conf"
	"github.com/gwaylib/database"
)

var dbFile = conf.RootDir() + "/etc/db.cfg"

func GetCache(section string) *database.DB {
	return database.GetCache(dbFile, section)
}

func HasCache(section string) (*database.DB, error) {
	return database.HasCache(dbFile, section)
}

// 当使用了Cache，在程序退出时可调用database.CloseCache进行正常关闭数据库连接
func CloseCache() {
	database.CloseCache()
}
