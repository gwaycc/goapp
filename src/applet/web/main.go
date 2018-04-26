package main

import (
	"net/http"
	"time"

	"applet/web/model/log"
	_ "applet/web/route"

	"golang.org/x/net/context"
)

func init() {
	http.Handle("/", http.StripPrefix("/", http.FileServer(http.Dir("./public"))))
}

type FilterHandler struct {
}

func (h *FilterHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	defer func(start time.Time) {
		log.Printf("%s %s\n", log.ColorForMethod(r.Method), r.URL.String())
	}(time.Now())

	http.DefaultServeMux.ServeHTTP(w, r)
}

func main() {
	// 过虑器
	filter := &FilterHandler{}
	addr := ":8081"
	log.Println("Listen: " + addr)
	log.Fatal(http.ListenAndServe(addr, filter))

	// Test goget package for $PJ_ROOT/.goget
	log.Println(context.TODO)
}
