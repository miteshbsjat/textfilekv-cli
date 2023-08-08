package main

import (
	"fmt"
	"testing"

	"github.com/miteshbsjat/goshell"
)

func TestMain(t *testing.T) {
	kvfile := "/tmp/test-kv.txt"
	binfile := "/tmp/textfilekv-cli"
	output, _ := goshell.RunCommand("rm -f " + kvfile)
	fmt.Println(output)

	output, err := goshell.RunCommand("go build -o " + binfile + " textfilekv-cli.go")
	if err != nil {
		t.Errorf("Failed to build binary file %s\n", binfile)
	}
	fmt.Println(output)

	val := "val1"
	key := "key1"
	cmd := binfile + " set -f " + kvfile + " -k " + key + " -v " + val
	output, err = goshell.RunCommand(cmd)
	if err != nil {
		t.Errorf("Failed to set key %s in %s\n%v\n%s\n", key, binfile, err, cmd)
	}
	fmt.Println(output)

	cmd = binfile + " get -f " + kvfile + " -k " + key
	output, err = goshell.RunCommand(cmd)
	if err != nil {
		t.Errorf("Failed to get key %s in %s\n%v\n%s\n", key, binfile, err, cmd)
	}
	fmt.Println(output)
	if output != val {
		t.Errorf("Store val = %s   !=   get val = %s", output, val)
	}

	cmd = binfile + " delete -f " + kvfile + " -k " + key
	output, err = goshell.RunCommand(cmd)
	if err != nil {
		t.Errorf("Failed to delete key %s in %s\n%v\n%s\n", key, binfile, err, cmd)
	}
	fmt.Println(output)

	// Cleanup
	output, _ = goshell.RunCommand("rm -f " + kvfile)
	fmt.Println(output)
}
