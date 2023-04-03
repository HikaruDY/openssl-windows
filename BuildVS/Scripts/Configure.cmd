@echo off
REM	Configure <Arch> <OpenSSL dir> <Perl dir> <nasm base dir>

call "%~dp0\Common" %* || GOTO ERR

pushd "%BUILD_DIR%" || GOTO ERR

IF /I "%~2" == "/Clean" (
	del makefile
	GOTO :EOF
)

IF EXIST "makefile"  echo Configure: warning: Already configured. skipping... & GOTO EOF

perl "%SOURCE_DIR%\Configure" %CFGOC%


GOTO EOF
:ERR
exit /b 1
:EOF
exit /b 0
