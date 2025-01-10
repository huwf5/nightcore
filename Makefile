BUILD_DIR = build

.PHONY: all
all: build

.PHONY: build
build: clean
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake .. && make -j $(nproc)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
	rm -rf deps/out
	rm -rf deps/src
	rm -rf deps/tmp
