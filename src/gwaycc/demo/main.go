package main

import (
	"fmt"
	"os"
	"os/signal"

	"gwaycc/module/db"
)

func main() {
	fmt.Println("OK")
	mdb := db.GetCache("master")
	// defer database.Close(mdb)
	_ = mdb

	fmt.Println("[ctrl+c to exit]")
	end := make(chan os.Signal, 2)
	signal.Notify(end, os.Interrupt, os.Kill)
	<-end
}
