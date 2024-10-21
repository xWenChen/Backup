@echo off
REM 检查是否传入参数，输出日志中不能用 # > ( 等特殊符号
if "%~1"=="" (
	echo.
    echo »»»»»»»»»» 请提供视频路径。
	echo.
    exit /b 1
)

REM 检查目录是否存在
if exist "%1" (
	echo.
    echo »»»»»»»»»» 路径存在: %1
	echo.
) else (
	echo.
    echo »»»»»»»»»» 路径不存在: %1
	echo.
	exit /b 1
)

REM 运行命令并传入参数
echo.
echo »»»»»»»»»» 运行命令，传入的参数是: %1
echo.
cd F:\work\scripts\
REM 这里可以替换为你想要运行的命令
javac Video2Pic.java
echo.
echo »»»»»»»»»» F:\work\scripts\Video2Pic.class 生成成功
echo.
java Video2Pic %1
