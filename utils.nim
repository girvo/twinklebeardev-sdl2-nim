import os
import sdl2
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
