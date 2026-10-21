BIN := $(HOME)/.local/bin/im
SRC := im.swift

.PHONY: all install clean

all: install

install:
	@mkdir -p $(dir $(BIN))
	swiftc -O $(SRC) -o $(BIN)
	@echo "built -> $(BIN)"

clean:
	rm -f $(BIN)
