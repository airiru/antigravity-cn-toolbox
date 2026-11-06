@echo off
chcp 65001 >nul
setlocal
title Antigravity 中文汉化 - 一键安装

echo ==================================================
echo    Antigravity 中文汉化（便携版 / 免装 Node）
echo ==================================================
echo.

set "AGY_EXE="
if exist "%LOCALAPPDATA%\Programs\antigravity\Antigravity.exe" set "AGY_EXE=%LOCALAPPDATA%\Programs\antigravity\Antigravity.exe"
if not defined AGY_EXE if exist "%LOCALAPPDATA%\Programs\Antigravity\Antigravity.exe" set "AGY_EXE=%LOCALAPPDATA%\Programs\Antigravity\Antigravity.exe"
if not defined AGY_EXE if exist "%LOCALAPPDATA%\Antigravity\Antigravity.exe" set "AGY_EXE=%LOCALAPPDATA%\Antigravity\Antigravity.exe"
if not defined AGY_EXE if exist "%ProgramFiles%\Antigravity\Antigravity.exe" set "AGY_EXE=%ProgramFiles%\Antigravity\Antigravity.exe"
if not defined AGY_EXE if exist "%ProgramFiles%\antigravity\Antigravity.exe" set "AGY_EXE=%ProgramFiles%\antigravity\Antigravity.exe"

if not defined AGY_EXE (
    echo [提示] 没有自动找到 Antigravity.exe
    echo        请把 Antigravity.exe 直接拖进本窗口，然后按回车：
    set /p "AGY_EXE=路径: "
)

set "AGY_EXE=%AGY_EXE:"=%"

if not exist "%AGY_EXE%" (
    echo.
    echo [错误] 路径无效：%AGY_EXE%
    echo.
    pause
    exit /b 1
)

echo [1/3] 客户端位置：%AGY_EXE%
echo.
echo [2/3] 正在注入汉化，约需 10-60 秒，期间会自动关闭并重启 Antigravity，请勿关闭本窗口...
echo.

set "ELECTRON_RUN_AS_NODE=1"
"%AGY_EXE%" "%~dp0localization_engine.js" --brand-title english %*
set "RC=%ERRORLEVEL%"
set "ELECTRON_RUN_AS_NODE="

echo.
if not "%RC%"=="0" (
    echo [失败] 汉化未完成，请把上面的报错信息截图反馈。
    echo        如界面出现异常，可运行同目录下的「一键还原.bat」恢复官方英文。
    echo.
    pause
    exit /b 1
)

echo [3/3] 汉化完成！如果界面还是英文，请手动关闭并重新打开 Antigravity。
echo.
pause
exit /b 0
