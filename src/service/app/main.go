package main

import (
	"fmt"
	"os"
	"os/signal"

	"module/db"
)

func main() {
	fmt.Println("OK")
	mdb := db.DB("master")
	defer mdb.Close()

	fmt.Println("[ctrl+c to exit]")
	end := make(chan os.Signal, 2)
	signal.Notify(end, os.Interrupt, os.Kill)
	<-end
}
