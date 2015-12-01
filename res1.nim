import sdl2
import res_path

when isMainModule:
  if int(sdl2.init(sdl2.INIT_VIDEO)) != 0:
    echo("SDL2 Error: " & $sdl2.getError())
    quit(1)

  var
    win: WindowPtr = sdl2.createWindow("Hello World!", 100, 100, 640, 480, sdl2.SDL_WINDOW_SHOWN)

  if win == nil:
    echo("SDL2 Error: " & $sdl2.getError())
    quit(1)

  delay(2000)
  quit(0)
