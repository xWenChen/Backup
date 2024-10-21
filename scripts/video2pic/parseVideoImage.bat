@echo off
REM 检查是否传入参数
if "%~1"=="" (
    echo >>>>>>>>>> 请提供视频路径。
    exit /b 1
)

REM 运行命令并传入参数
echo >>>>>>>>>> 运行命令，传入的参数是: %1
cd F:\work\scripts\
REM 这里可以替换为你想要运行的命令
javac Video2Pic.java
echo >>>>>>>>>> F:\work\scripts\Video2Pic.class 生成成功
java Video2Pic %1
