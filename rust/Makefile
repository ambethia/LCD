TARGET    = lcd
ROOT_DIR  = .
SRC_DIR   = $(ROOT_DIR)/src
SRC_CRATE = $(TARGET).rs
BUILD_DIR = $(ROOT_DIR)/bin

$(TARGET):
	@mkdir -p $(BUILD_DIR)
	@rustc $(SRC_DIR)/$(SRC_CRATE) --out-dir=$(BUILD_DIR)

all: $(TARGET)

clean:
	rm -R -f $(BUILD_DIR)
