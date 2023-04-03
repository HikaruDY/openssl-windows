@echo off
REM	Configure <Arch> <OpenSSL dir> <Perl dir> <nasm base dir>

call "%~dp0\Common" %* || GOTO ERR

pushd "%BUILD_DIR%" || GOTO ERR

IF /I "%~2" == "/Clean" (
	del /s /q /f *.dll *.exe *.lib *.obj *.pdb *.h
	GOTO :EOF
)

set LDFLAGS=/nologo /Machine:%ARCH%
nmake /E || GOTO ERR

GOTO EOF
:ERR
exit /b 1
:EOF
exit /b 0
