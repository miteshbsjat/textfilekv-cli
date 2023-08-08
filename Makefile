all: mod test vet fmt build run

test:
	go test ./...

vet:
	go vet ./...

fmt:
	go list -f '{{.Dir}}' ./... | grep -v /vendor/ | xargs -L1 gofmt -l

mod:
	go mod tidy
	go mod vendor

build:
	go build -o bin/textfilekv-cli textfilekv-cli.go

run:
	./bin/textfilekv

install:
	go install -v ./...

clean:
	rm -f bin/*
