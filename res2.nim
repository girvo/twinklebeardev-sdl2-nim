import os
import sdl2
import res_path

const
  ScreenWidth = 640
  ScreenHeight = 480

###
# Logs out SDL2 errors
# TODO: Need to allow choosing of output stream
##
proc logSDLError(msg: string, shouldQuit: bool = true) =
  echo(msg & " error: " & $sdl2.getError())
  if shouldQuit: sdl2.quit()

###
# Loads textures from bitmaps
##
proc loadTexture(file: string, ren: RendererPtr): TexturePtr =
  var
    texture: TexturePtr = nil
    loadedImage: SurfacePtr = sdl2.loadBMP(file)
  if loadedImage != nil:
    texture = sdl2.createTextureFromSurface(ren, loadedImage)
    loadedImage.freeSurface()
    if texture == nil:
      logSDLError("CreateTextureFromSurface")
  else:
    logSDLError("LoadBMP")
  return texture

###
# Renders a texture preserving it's aspect ratio
##
proc renderTexture(tex: TexturePtr, ren: RendererPtr, x: int, y: int) =
  var dst: Rect
  dst.x = cint(x)
  dst.y = cint(y)
  tex.queryTexture(nil, nil, addr(dst.w), addr(dst.h))
  ren.copy(tex, nil, addr(dst))

proc main() =
  if int(sdl2.init(sdl2.Init_Everything)) != 0:
    logSDLError("SDL_Init")

  var window: WindowPtr = sdl2.createWindow("Lesson 2", 100, 100, ScreenWidth, ScreenHeight, sdl2.SDL_Window_Shown)
  if window == nil:
    logSDLError("CreateWindow")

  var renderer: RendererPtr = sdl2.createRenderer(window, -1, Renderer_Accelerated or Renderer_PresentVsync)
  if renderer == nil:
    logSDLError("CreateRenderer", false)
    window.destroy()
    sdl2.quit()

  var
    resPath = getResourcePath("Lesson2")
    background: TexturePtr = loadTexture(resPath & DirSep & "background.bmp", renderer)
    image: TexturePtr = loadTexture(resPath & DirSep & "image.bmp", renderer)

  if background == nil or image == nil:
    logSDLError("loadTexture")
    renderer.destroy()
    window.destroy()
    sdl2.quit()

  renderer.clear()
  var bW, bH, iW, iH: cint

  # Background
  background.queryTexture(nil, nil, addr(bW), addr(bH))
  renderTexture(background, renderer, 0, 0)
  renderTexture(background, renderer, bW, 0)
  renderTexture(background, renderer, 0, bH)
  renderTexture(background, renderer, bW, bH)

  # Foreground
  image.queryTexture(nil, nil, addr(iW), addr(iH))
  var x: int = int(ScreenWidth / 2 - int(iW) / 2);
  var y: int = int(ScreenHeight / 2 - int(iH) / 2);
  renderTexture(image, renderer, x, y)
  renderer.present()
  delay(1000)

  # Cleanup
  background.destroy()
  image.destroy()
  renderer.destroy()
  window.destroy()
  sdl2.quit()

when isMainModule: main()
