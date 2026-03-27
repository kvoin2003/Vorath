@echo off
setlocal

:: 0) Встроенный JRE (runtime/)
if exist "%~dp0runtime\bin\javaw.exe" (
    start "" "%~dp0runtime\bin\javaw.exe" -cp build com.gameio.client.ClientMain %*
    exit /b
)

:: 1) PATH
where javaw.exe >nul 2>&1 && (
    start "" javaw -cp build com.gameio.client.ClientMain %*
    exit /b
)
where java.exe >nul 2>&1 && (
    start "" java -cp build com.gameio.client.ClientMain %*
    exit /b
)

:: 2) JAVA_HOME
if defined JAVA_HOME (
    if exist "%JAVA_HOME%\bin\javaw.exe" (
        start "" "%JAVA_HOME%\bin\javaw.exe" -cp build com.gameio.client.ClientMain %*
        exit /b
    )
)

:: 3) Program Files - Adoptium
for /d %%J in ("%ProgramFiles%\Eclipse Adoptium\*") do (
    if exist "%%~J\bin\javaw.exe" (
        start "" "%%~J\bin\javaw.exe" -cp build com.gameio.client.ClientMain %*
        exit /b
    )
)

:: 4) Program Files - Java (Oracle)
for /d %%J in ("%ProgramFiles%\Java\*") do (
    if exist "%%~J\bin\javaw.exe" (
        start "" "%%~J\bin\javaw.exe" -cp build com.gameio.client.ClientMain %*
        exit /b
    )
)

:: 5) Program Files (x86) - Java
for /d %%J in ("%ProgramFiles(x86)%\Java\*") do (
    if exist "%%~J\bin\javaw.exe" (
        start "" "%%~J\bin\javaw.exe" -cp build com.gameio.client.ClientMain %*
        exit /b
    )
)

:: 6) Program Files - Microsoft
for /d %%J in ("%ProgramFiles%\Microsoft\*") do (
    if exist "%%~J\bin\javaw.exe" (
        start "" "%%~J\bin\javaw.exe" -cp build com.gameio.client.ClientMain %*
        exit /b
    )
)

:: Не найдена
echo.
echo  ======================================
echo   Java не найдена!
echo   Скачайте Java: https://adoptium.net
echo  ======================================
echo.
start https://adoptium.net/temurin/releases/
pause
