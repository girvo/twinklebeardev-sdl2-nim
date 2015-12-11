import os
import math
import sdl2, sdl2/image
import ./utils as engine

const
  ScreenWidth: int = 640
  ScreenHeight: int = 480

var
  shouldQuit = false
  evt = sdl2.defaultEvent
  window: WindowPtr
  renderer: RendererPtr
  img: TexturePtr

proc loop() =
  case evt.kind:
  of QuitEvent:
    shouldQuit = true
  of KeyDown:
    shouldQuit = true
  of MouseButtonDown:
    shouldQuit = true
  else:
    discard
  renderer.clear()
  img.renderTexture(renderer, 0, 0)
  renderer.present()

proc main() =
  # Setup windown and renderer
  (window, renderer) = setupSDL(ScreenWidth, ScreenHeight)
  # Load our img
  var filepath = getResourcePath("Lesson4")
  img = loadTexture(filepath & DirSep & "image.png", renderer)
  if img == nil:
    cleanup(img, renderer, window)
    sdl2.quit()
  # Start our main loop
  while not shouldQuit:
    while pollEvent(evt):
      loop()
  echo("Done.")
  cleanup(img, renderer, window)
  quit(0)

when isMainModule: main()
