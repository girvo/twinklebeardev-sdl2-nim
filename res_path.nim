import sdl2
import os

proc getResourcePath*(subDir: string = ""): string =
  var
    baseRes: string = getCurrentDir()
    suffixDir: string = ""

  if subDir != "":
    suffixDir = DirSep & subDir

  return baseRes & DirSep & "assets" & suffixDir
