package etc

import "github.com/gwaylib/conf"
import "github.com/gwaylib/conf/ini"

var (
	Ini = ini.NewIni(conf.RootDir() + "/etc/")
	Etc = Ini.Get("etc.cfg")
)
