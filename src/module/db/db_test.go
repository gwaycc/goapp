package db

import (
	"testing"
)

func TestDB(t *testing.T) {
	mdb, err := HasCache("master")
	if err != nil {
		t.Fatal(err)
	}
	mdb.Close()
}
