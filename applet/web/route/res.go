package route

import (
	"io/ioutil"
	"net/http"
)

func init() {
	http.HandleFunc("/res", Res)
}

func Res(w http.ResponseWriter, r *http.Request) {
	data, err := ioutil.ReadFile("res/test.json")
	if err != nil {
		panic(err)
	}
	if _, err := w.Write(data); err != nil {
		panic(err)
	}
	return
}
