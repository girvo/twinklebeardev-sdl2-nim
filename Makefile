all: res2

run: res2
	@./$<

res1: res1.nim
	nim c res1.nim

res2: res2.nim
	nim c res2.nim

.PHONY: all run
