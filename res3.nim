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
  if int(sdl2.init(sdl2.Init_Everything)) != 0:
    logSDLError("SDL_Init")

  # Initialise the image subsystem first
  init()

  var window: WindowPtr = sdl2.createWindow("Lesson 2", 100, 100, cint(ScreenWidth), cint(ScreenHeight), sdl2.SDL_Window_Shown)
  if window == nil:
    logSDLError("CreateWindow")

  var renderer: RendererPtr = sdl2.createRenderer(window, -1, Renderer_Accelerated or Renderer_PresentVsync)
  if renderer == nil:
    logSDLError("CreateRenderer", false)
    window.destroy()
    sdl2.quit()

  # Now lets do the rest of what we wanna do
  var
    filepath = getResourcePath("Lesson3")
    background = loadTexture(filepath & "background.png", renderer)
    image = loadTexture(filepath & "image.png", renderer)
  if background == nil or image == nil:
    cleanup(background, image, renderer, window)
    sdl2.quit()





when isMainModule: main()
