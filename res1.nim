import os
import sdl2
import res_path

proc quitWithError(ctx: string = "SDL", quitViaSDL: bool = false) =
  echo(ctx & " Error: " & $sdl2.getError())
  if quitViaSDL:
    sdl2.quit()
  quit(1)

proc run() =
  # Initialise SDL2 video subsystem
  if int(sdl2.init(INIT_VIDEO)) != 0:
    quitWithError()

  # Create our window and hang on to a pointer
  var win = sdl2.createWindow("Hello World!", 100, 100, 640, 480, SDL_WINDOW_SHOWN)
  if win == nil:
    quitWithError("CreateWindow")

  # Create our renderer
  var ren = sdl2.createRenderer(win, -1, sdl2.RENDERER_ACCELERATED and sdl2.RENDERER_PRESENTVSYNC)
  if ren == nil:
    quitWithError("CreateRenderer", true)

  # Load a surface
  var
    imagePath: string = getResourcePath("Lesson1") & DirSep & "hello.bmp"
    bmp: SurfacePtr = sdl2.LoadBmp(imagePath)

  if bmp == nil:
    sdl2.destroy(ren)
    sdl2.destroy(win)
    quitWithError("LoadBmp")

# Run our game
when isMainModule: run()
