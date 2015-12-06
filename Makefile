all: res3

run: res3
	@./$<

res1: res1.nim
	nim c res1.nim

res2: res2.nim
	nim c res2.nim

res3: res3.nim
	nim c res3.nim

.PHONY: all run
