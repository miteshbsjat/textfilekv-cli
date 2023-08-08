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
* Download From [Release](https://github.com/miteshbsjat/textfilekv-cli/releases), e.g.
[textfilekv-cli v0.0.9 Linux AMD64](https://github.com/miteshbsjat/textfilekv-cli/releases/download/v0.0.9/textfilekv-cli-v0.0.9-linux-amd64.tar.gz)
```bash
cd /tmp
wget https://github.com/miteshbsjat/textfilekv-cli/releases/download/v0.0.9/textfilekv-cli-v0.0.9-linux-amd64.tar.gz
```

* Extract the achieve
```bash
tar -zxvf textfilekv-cli-v0.0.9-linux-amd64.tar.gz 
```

* Install the binary in a directory in your `$PATH`
```bash
install -s linux-amd64/textfilekv-cli ~/bin/
```

* Verify the installation
```bash
which textfilekv-cli 
/home/mitesh/bin/textfilekv-cli
```


### Alias Setting and Shell Command Auto-Completion 

* Using `/tmp/demo.txt` for the demo, you can use any number of files for separate KV stores.

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

 ## Acknowledgement

 I would like to extend my heartfelt gratitude to my family and friends for their unwavering support and encouragement throughout this endeavor. Your belief in me has been a constant source of inspiration, and I am truly grateful for the moments we've shared.

To my teachers, thank you for your dedication to my education and for fostering an environment of learning that has shaped my skills and perspective. Your guidance has been instrumental in my growth.

A special note of appreciation goes to P. A. Venkatesh, Nilesh Deshmukh, and Puneet Vyas for their invaluable contribution to testing and refining the code repository. Your insights and feedback have played a crucial role in enhancing the quality and functionality of the project.

Your collective support, encouragement, and insights have been instrumental in making this project a reality. Thank you for being a part of my journey.
