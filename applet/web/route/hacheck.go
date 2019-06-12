package route

import (
	"net/http"
)

func init() {
	http.HandleFunc("/hacheck", Hacheck)
}

func Hacheck(w http.ResponseWriter, r *http.Request) {
	if _, err := w.Write([]byte("1")); err != nil {
		panic(err)
	}
	return
}
