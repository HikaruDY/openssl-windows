@echo off
REM	Configure <Arch> <OpenSSL dir> <Perl dir> <nasm base dir>

call "%~dp0\Common" %* || GOTO ERR

pushd "%BUILD_DIR%" || GOTO ERR

IF /I "%~2" == "/Clean" (
	del /s /q /f *.dll *.exe *.lib *.obj *.pdb *.h
	GOTO :EOF
)

set LDFLAGS=/nologo /Machine:%ARCH%
set CFLAGS=/W3 /wd4090 /nologo /O2
set CNF_CFLAGS=/Gs0 /GF /Gy /MT

nmake /E depend || GOTO ERR
nmake /E build_generated || GOTO ERR
nmake /E build_libs_nodep || GOTO ERR
REM //nmake /E libcrypto.lib libcrypto_static.lib libssl.lib libssl_static.lib libcrypto-3.dll libssl-3.dll || GOTO ERR
nmake /E apps\openssl.exe || GOTO ERR
nmake /E build_modules_nodep || GOTO ERR

GOTO EOF
:ERR
exit /b 1
:EOF
exit /b 0
