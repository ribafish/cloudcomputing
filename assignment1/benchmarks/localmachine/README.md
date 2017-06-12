# Usage

## Prerequisites

### Install fio

On Linux: `sudo apt-get install -y fio` 

On MacOSX: `brew install fio`

### Compile linpack & memsweep

Go to the material/assignment1_benchmarking_tools folder and run

```
chmod +x linpack.sh; ./linpack.sh
chmod +x memsweep.sh; ./memsweep.sh
```


once that the source is compiled and go back to the folder where
perform_tests.sh is located e.g. (cd -)

This is required due to macOS incompatibilities - sorry `¯\_(ツ)_/¯ `

### Run benchmarks

make executable `./chmod +x perform.sh` and run

```
./perform_tests.sh
```

It should create 8 files all mangled with the start datetime of
benchmark.
