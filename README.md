# TwinkleBear's SDL2 Tutorials

http://www.willusher.io/pages/sdl2/

This is a conversion of the code within that tutorial to Nim

## C memory management discussion

From IRC:

```
> 10:10 < Araq> void initT(Foo* foo); // let host language do the allocation
> 10:11 < Araq> let x = newFoo() # can use Nim's GC here :-)
> 10:11 < Araq> initT(x) # pass to C
```
