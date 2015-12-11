import os
import sdl2, sdl2/image
import macros

###
# Logs out SDL2 errors
# TODO: Need to allow choosing of output stream
##
proc logSDLError*(msg: string, shouldQuit: bool = true) =
  echo(msg & " error: " & $sdl2.getError())
  if shouldQuit: sdl2.quit()

proc getResourcePath*(subDir: string = ""): string =
  var
    baseRes: string = getCurrentDir()
    suffixDir: string = ""

  if subDir != "":
    suffixDir = DirSep & subDir

  return baseRes & DirSep & "assets" & suffixDir

###
# Cleanup macro for all SDL types
##
macro cleanup*(n: varargs[expr]): stmt =
  result = newNimNode(nnkStmtList, n)
  for i in 0..n.len-1:
    add(result, newCall("destroy", n[i]))

###
# Intialise window, renderer
##
proc setupSDL*(w: int, h: int): (WindowPtr, RendererPtr) =
  if int(sdl2.init(sdl2.Init_Everything)) != 0:
    logSDLError("SDL_Init")
  var window: WindowPtr = sdl2.createWindow("Lesson 4", 100, 100, cint(w), cint(h), sdl2.SDL_Window_Shown)
  if window == nil:
    logSDLError("CreateWindow")
  var renderer: RendererPtr = sdl2.createRenderer(window, -1, Renderer_Accelerated or Renderer_PresentVsync)
  if renderer == nil:
    logSDLError("CreateRenderer", false)
    window.destroy()
    sdl2.quit()
  return (window, renderer)

###
# Texture loading
##
proc loadTexture*(file: string, ren: RendererPtr): TexturePtr =
  var texture: TexturePtr = loadTexture(ren, file)
  if texture == nil:
    logSDLError("LoadTexture")
  return texture

###
# Texture rendering
##
proc renderTexture*(tex: TexturePtr, ren: RendererPtr, x: int, y: int, w: int, h: int) =
  var dst: Rect
  dst.x = cint(x)
  dst.y = cint(y)
  dst.w = cint(w)
  dst.h = cint(h)
  ren.copy(tex, nil, addr(dst))

proc renderTexture*(tex: TexturePtr, ren: RendererPtr, x: int, y: int) =
  var w,h: cint
  tex.queryTexture(nil, nil, addr(w), addr(h))
  renderTexture(tex, ren, x, y, w, h)

