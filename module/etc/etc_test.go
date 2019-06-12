package etc

import (
	"testing"
)

func TestEtc(t *testing.T) {
	if Etc.Int64("testing", "int") != 1 {
		t.Fatal(Etc.Int64("testing", "int"))
	}
	if !Etc.Bool("testing", "bool") {
		t.Fatal(Etc.Bool("testing", "bool"))
	}
}
