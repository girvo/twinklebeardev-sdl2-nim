NIMOPTS=-d:debug

all: res4

run: res4
	@./$<

res1: res1.nim
	nim c $(NIMOPTS) res1.nim

res2: res2.nim
	nim c $(NIMOPTS) res2.nim

res3: res3.nim
	nim c $(NIMOPTS) res3.nim

res4: res4.nim
	nim c $(NIMOPTS) res4.nim

.PHONY: all run
