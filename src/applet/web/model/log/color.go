package log

import (
	"github.com/labstack/gommon/color"
)

func ColorForStatus(code string) string {
	switch {
	case code >= "200" && code < "300":
		return color.Green(code)
	case code >= "300" && code < "400":
		return color.White(code)
	case code >= "400" && code < "500":
		return color.Yellow(code)
	default:
		return color.Red(code)
	}
}

func ColorForMethod(method string) string {
	switch method {
	case "GET":
		return color.Blue(method)
	case "POST":
		return color.Cyan(method)
	case "PUT":
		return color.Yellow(method)
	case "DELETE":
		return color.Red(method)
	case "PATCH":
		return color.Green(method)
	case "HEAD":
		return color.Magenta(method)
	case "OPTIONS":
		return color.White(method)
	default:
		return color.Reset(method)
	}
}
