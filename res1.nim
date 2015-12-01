import sdl2
import res_path

if int(sdl2.init(sdl2.INIT_VIDEO)) != 0:
  echo("SDL2 Error: " & $sdl2.getError())
  quit(1)
