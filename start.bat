@echo off
chcp 65001 >nul
echo ========================================
echo   InSAR 地灾形变可视化系统 - 本地启动
echo ========================================
echo.
echo 正在启动本地服务器...
echo 启动后请在浏览器打开: http://localhost:8080
echo 按 Ctrl+C 可停止服务器
echo.
cd /d "%~dp0"
python -m http.server 8080
pause
