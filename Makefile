NIMOPTS=-d:debug

all: res3

run: res3
	@./$<

res1: res1.nim
	nim c $(NIMOPTS) res1.nim

res2: res2.nim
	nim c $(NIMOPTS) res2.nim

res3: res3.nim
	nim c $(NIMOPTS) res3.nim

.PHONY: all run
