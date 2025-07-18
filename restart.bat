@echo off
for /f "delims=" %%i in (pidfile.txt) do (
  taskkill /pid %%i /f
)
:while
if exist webos_update.jar (
   for /f "delims=" %%i in (pidfile.txt) do (
     taskkill /pid %%i /f
   )
   del webos.jar
   rename webos_update.jar webos.jar
   goto :while
)
set "javaPath=..\jre\bin\java.exe"
set "lc=java"
if exist "%javaPath%" set "lc=%javaPath%"
set "jb=%lc% -Dfile.encoding=UTF-8 -javaagent:webos.jar -XX:+UseG1GC -Xms128m -jar webos.jar"
mshta vbscript:createobject("wscript.shell").run("%jb%",0)(window.close)
exit