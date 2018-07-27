# !/bin/sh
#
# Install:
# go get -u github.com/go-swagger/go-swagger/cmd/swagger
# sudo mv $GOBIN/swagger /usr/local/bin
#
swagger generate spec -o ./public/swagger/swagger.json
