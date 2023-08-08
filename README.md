# CLI for textfilekv

Command Line Interface for [textfilekv](https://pkg.go.dev/github.com/miteshbsjat/textfilekv) golang package,
which uses flat file for key value store.

`textfilekv` is a pure Go based key-value store on plain text file as `=` delimited lines of text.
Each line represent a new record. This file can be even edited by hand when not in use to edit/update.

## Table of Contents

- [Getting Started](#getting-started)
  - [Installing](#installing)
  - [Usage](#usage)
  - [Testing](#testing)
- [Features](#features)

## Getting Started

### Installing

#### Linux
* Download From [Release](https://github.com/miteshbsjat/textfilekv-cli/releases)
```bash
cd /tmp
```
* Extract the achieve
```bash
tar -zxvf textfilekv-cli-v0.0.4-linux-amd64.tar.gz 
```

* Install the binary in a directory in `$PATH`
```bash
install -s linux-amd64/textfilekv-cli ~/bin/
```

* Verify the installation
```bash
which textfilekv-cli 
/home/mitesh/bin/textfilekv-cli
```


### Alias Setting and Shell Command Auto-Completion 
```bash
alias tkv-demo="textfilekv-cli -f /tmp/demo.txt"
```

### Usage

* Setting Key Value
```bash
tkv-demo set -k key1 -v val1
```

```bash
Key-value pair added or updated successfully.
```

* Getting Key
```bash
tkv-demo get -k key1
```

```bash
val1
```

----

* Getting value from other commands (bash)
```bash
tkv-demo set -k home_dir -v $(echo $HOME)
```
```bash
tkv-demo get -k home_dir 
```
* Output
```bash
/home/mitesh
```
 ----
