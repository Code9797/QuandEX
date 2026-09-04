@echo off
setlocal
set "PROJECT_DIR=%~dp0"
set "DIST_DIR=%PROJECT_DIR%.gradle-dist\gradle-8.9"
set "ZIP_FILE=%PROJECT_DIR%.gradle-dist\gradle-8.9-bin.zip"

if exist "%DIST_DIR%\bin\gradle.bat" goto run
if not exist "%PROJECT_DIR%.gradle-dist" mkdir "%PROJECT_DIR%.gradle-dist"
if not exist "%ZIP_FILE%" powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -UseBasicParsing 'https://services.gradle.org/distributions/gradle-8.9-bin.zip' -OutFile '%ZIP_FILE%'"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Force '%ZIP_FILE%' '%PROJECT_DIR%.gradle-dist'"

:run
call "%DIST_DIR%\bin\gradle.bat" %*
endlocal
