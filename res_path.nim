import sdl2
import os

proc getResourcePath*(subDir: string = ""): cstring =
  var
    baseRes: string = getCurrentDir()
    suffixDir: string = ""

  if subDir != "":
    suffixDir = DirSep & subDir

  return cstring(baseRes & DirSep & "assets" & suffixDir)
