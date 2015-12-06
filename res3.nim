import os
import sdl2, sdl2/image
import utils

const
  ScreenWidth: int = 640
  ScreenHeight: int = 480
  TileSize: int = 40

proc loadTexture(file: string, renderer: RendererPtr): TexturePtr =
  var texture: TexturePtr = loadTexture(renderer, file)
  if texture == nil:
    logSDLError("LoadTexture")
  return texture

proc renderTexture(tex: TexturePtr, renderer: RendererPtr, x: int, y: int, w: int, h: int) =
  var
    dst: Rect
  dst.x = cint(x)
  dst.y = cint(y)
  dst.w = cint(w)
  dst.h = cint(h)
  renderer.copy(tex, nil, addr(dst))
