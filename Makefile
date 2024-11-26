# Compiler and flags
CC = gcc
CFLAGS = -I "include" -Wall -Wextra -Wpedantic
LDFLAGS = -L "lib" -lraylib -lwinmm -lgdi32 -lopengl32

# Directories
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build
BIN_DIR = bin

# Files
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC))
OUT = $(BIN_DIR)/main.exe

# Targets
all: $(OUT)

# Link object files to create the executable
$(OUT): $(OBJ)
	@mkdir -p $(BIN_DIR)
	$(CC) -o $@ $^ $(LDFLAGS)

# Compile source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	$(CC) -c $< -o $@ $(CFLAGS)

# Clean up build and binary files
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Debug build
debug: CFLAGS += -g -DDEBUG
debug: clean all

# Release build
release: CFLAGS += -O2
release: clean all

# Phony targets to avoid conflicts with files named 'clean', 'debug', etc.
.PHONY: all clean debug release
