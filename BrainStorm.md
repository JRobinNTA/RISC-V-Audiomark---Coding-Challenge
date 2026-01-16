[11/01/2026]

Since the preffered compiler riscv32-unknown-elf-gcc did not had working binutils changed the compiler
to xpack-riscv-none-elf-gcc

```bash
wget https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v15.2.0-1/xpack-riscv-none-elf-gcc-15.2.0-1-linux-x64.tar.gz

tar xf xpack-riscv-none-elf-gcc-15.2.0-1-linux-x64.tar.gz
```

[12/01/2026]

Decided to use full on linux env inside qemu to run the code since
It was extremely hard to get the bare metal version working, even after trying to run it using openSBI

also edited the make file to include the qemu run command

[15/01/2026]

Discovered QEMU was not a reliable source for vector performance metrics

Built gem5 for RISCV ISA and verified the vector speed up.
