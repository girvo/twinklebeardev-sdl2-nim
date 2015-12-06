import os
import sdl2, sdl2/image
import utils

const
  ScreenWidth: int = 640
  ScreenHeight: int = 480
  TileSize: int = 40

proc loadTexture(file: string, ren: RendererPtr): TexturePtr =
  var texture: TexturePtr = loadTexture(ren, file)
  if texture == nil:
    logSDLError("LoadTexture")
  return texture

proc renderTexture(tex: TexturePtr, ren: RendererPtr, x: int, y: int, w: int, h: int) =
  var dst: Rect
  dst.x = cint(x)
  dst.y = cint(y)
  dst.w = cint(w)
  dst.h = cint(h)
  ren.copy(tex, nil, addr(dst))

proc renderTexture(tex: TexturePtr, ren: RendererPtr, x: int, y: int) =
  var
    w: cint
    h: cint
  tex.queryTexture(nil, nil, addr(w), addr(h))
  renderTexture(tex, ren, x, y, w, h)

proc init() =
  if image.init(IMG_INIT_PNG) != IMG_INIT_PNG:
    logSDLError("IMG_Init")

proc main() =
  init()

when isMainModule: main()
