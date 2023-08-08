BINDIR      := $(CURDIR)/bin
INSTALL_PATH ?= /usr/local/bin
DIST_DIRS   := find * -type d -exec
TARGETS     := darwin/amd64 darwin/arm64 linux/amd64 linux/386 linux/arm linux/arm64 linux/ppc64le linux/s390x windows/amd64
TARGET_OBJS ?= darwin-amd64.tar.gz darwin-amd64.tar.gz.sha256 darwin-amd64.tar.gz.sha256sum darwin-arm64.tar.gz darwin-arm64.tar.gz.sha256 darwin-arm64.tar.gz.sha256sum linux-amd64.tar.gz linux-amd64.tar.gz.sha256 linux-amd64.tar.gz.sha256sum linux-386.tar.gz linux-386.tar.gz.sha256 linux-386.tar.gz.sha256sum linux-arm.tar.gz linux-arm.tar.gz.sha256 linux-arm.tar.gz.sha256sum linux-arm64.tar.gz linux-arm64.tar.gz.sha256 linux-arm64.tar.gz.sha256sum linux-ppc64le.tar.gz linux-ppc64le.tar.gz.sha256 linux-ppc64le.tar.gz.sha256sum linux-s390x.tar.gz linux-s390x.tar.gz.sha256 linux-s390x.tar.gz.sha256sum windows-amd64.zip windows-amd64.zip.sha256 windows-amd64.zip.sha256sum
BINNAME     ?= textfilekv-cli

GOBIN         = $(shell go env GOBIN)
ifeq ($(GOBIN),)
GOBIN         = $(shell go env GOPATH)/bin
endif
GOX           = $(GOBIN)/gox
GOIMPORTS     = $(GOBIN)/goimports
ARCH          = $(shell uname -p)


# ACCEPTANCE_DIR:=../acceptance-testing
# # To specify the subset of acceptance tests to run. '.' means all tests
# ACCEPTANCE_RUN_TESTS=.

# go option
PKG         := ./...
TAGS        :=
TESTS       := .
TESTFLAGS   :=
LDFLAGS     := -w -s
GOFLAGS     :=
CGO_ENABLED ?= 0

# Rebuild the binary if any of these files change
SRC := $(shell find . -type f -name '*.go' -print) go.mod go.sum

# Required for globs to work correctly
SHELL      = /usr/bin/env bash

GIT_COMMIT = $(shell git rev-parse HEAD)
GIT_SHA    = $(shell git rev-parse --short HEAD)
GIT_TAG    = $(shell git describe --tags --abbrev=0 --exact-match 2>/dev/null)
GIT_DIRTY  = $(shell test -n "`git status --porcelain`" && echo "dirty" || echo "clean")

ifdef VERSION
	BINARY_VERSION = $(VERSION)
endif
BINARY_VERSION ?= ${GIT_TAG}

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


$(GOX):
	(cd /; GO111MODULE=on go install github.com/mitchellh/gox@latest)

$(GOIMPORTS):
	(cd /; GO111MODULE=on go install golang.org/x/tools/cmd/goimports@latest)

# ------------------------------------------------------------------------------
#  release

.PHONY: build-cross
build-cross: LDFLAGS += -extldflags "-static"
build-cross: $(GOX)
	GOFLAGS="-trimpath" GO111MODULE=on CGO_ENABLED=0 $(GOX) -parallel=3 \
	  -output="_dist/{{.OS}}-{{.Arch}}/$(BINNAME)" -osarch='$(TARGETS)' \
	  $(GOFLAGS) -tags '$(TAGS)' -ldflags '$(LDFLAGS)' ./

.PHONY: dist
dist:
	( \
		cd _dist && \
		$(DIST_DIRS) cp ../LICENSE {} \; && \
		$(DIST_DIRS) cp ../README.md {} \; && \
		$(DIST_DIRS) tar -zcf textfilekv-cli-${VERSION}-{}.tar.gz {} \; && \
		$(DIST_DIRS) zip -r textfilekv-cli-${VERSION}-{}.zip {} \; \
	)

.PHONY: checksum
checksum:
	for f in $$(ls _dist/*.{gz,zip} 2>/dev/null) ; do \
		shasum -a 256 "$${f}" | sed 's/_dist\///' > "$${f}.sha256sum" ; \
		shasum -a 256 "$${f}" | awk '{print $$1}' > "$${f}.sha256" ; \
	done
# ------------------------------------------------------------------------------

run:
	./bin/textfilekv

install:
	go install -v ./...

clean:
	rm -f bin/*
	rm -rf _dist/*
