import os
import sdl2

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

