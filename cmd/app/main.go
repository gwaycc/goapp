package main

import (
	"fmt"
	"os"
	"os/signal"

	"github.com/gwaycc/goapp/module/db"
	"github.com/gwaycc/goapp/version"
)

func main() {
	fmt.Println("git commit:", version.GitCommit)
	mdb := db.GetCache("master")
	// defer database.Close(mdb)
	_ = mdb

	fmt.Println("[ctrl+c to exit]")
	end := make(chan os.Signal, 2)
	signal.Notify(end, os.Interrupt, os.Kill)
	<-end
}
