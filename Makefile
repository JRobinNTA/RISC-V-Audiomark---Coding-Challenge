TARGET_EXEC := final_program
CC          := riscv64-linux-gnu-gcc

OBJDUMP     := riscv64-linux-gnu-objdump
BUILD_DIR   := ./build
SRC_DIRS    := ./src

SRCS := $(shell find $(SRC_DIRS) -name '*.c')
OBJS := $(SRCS:$(SRC_DIRS)/%.c=$(BUILD_DIR)/%.o)

ASMS := $(OBJS:%.o=%.asm)

# UPDATE PATH
GEM5_DIR := /home/johnr/Devel/gem5

CFLAGS  := -march=rv64gcv -mabi=lp64d -g -O2 -static
LDFLAGS := -static

.PHONY: all run clean disasm


all: $(BUILD_DIR)/$(TARGET_EXEC) disasm

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)



$(BUILD_DIR)/%.asm: $(BUILD_DIR)/%.o
	$(OBJDUMP) -d -S $< > $@


disasm: $(ASMS)

$(BUILD_DIR)/%.o: $(SRC_DIRS)/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

run: $(BUILD_DIR)/$(TARGET_EXEC)
	$(GEM5_DIR)/build/RISCV/gem5.opt \
	  $(GEM5_DIR)/configs/deprecated/example/se.py \
	  --cpu-type=O3CPU \
	  --caches \
	  --l1d_size=64kB --l1i_size=32kB --l2_size=2MB \
	  --cmd=build/final_program

clean:
	rm -rf $(BUILD_DIR)
