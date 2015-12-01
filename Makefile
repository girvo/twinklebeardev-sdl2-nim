all: res1

run: res1
	@./res1

res1: res1.nim
	nim c --define:mac res1.nim

.PHONY: all run
