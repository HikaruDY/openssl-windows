@echo off

call :SET_ARCH "%~1"
call :PREPARE_BUILDDIR "%~2" || GOTO ERR

IF /I "%~2" == "/Clean" GOTO EOF

call :CHECK_PERL "%~3" || GOTO ERR
call :CHECK_NASM "%~4" || GOTO ERR

set PATH=%PERL_DIR%;%NASM_DIR%;%PATH%

GOTO :EOF

:SET_ARCH
	set ARCH=%~1
	set CFGOC=UNKNOWN

	IF /I "%~1" == "x86" (
		set CFGOC=VC-WIN32
	)

	IF /I "%~1" == "x64" (
		set CFGOC=VC-WIN64A
	)

	IF /I "%~1" == "ia64" (
		set CFGOC=VC-WIN64I
	)

	IF /I "%~1" == "a32" (
		set CFGOC=VC-WIN32-ARM
	)

	IF /I "%~1" == "a64" (
		set CFGOC=VC-WIN64-ARM
	)

	IF "%ARCH%" == "UNKNOWN" (
		echo error: Unsupported platform '%~1' specified.
		GOTO :ERR
	)
GOTO :EOF

:PREPARE_BUILDDIR
	set SOURCE_DIR=%~1
	set BUILD_DIR=%~dp0\..\%ARCH%
	IF NOT EXIST "%BUILD_DIR%" mkdir "%BUILD_DIR%"
GOTO :EOF

:CHECK_PERL
	set PERL_DIR=%~1

	IF     EXIST "%PERL_DIR%\perl.exe" echo PathEnv.props (6,0): warning: perl.exe is found at "%PERL_DIR%\perl.exe"
	IF NOT EXIST "%PERL_DIR%\perl.exe" echo PathEnv.props (6,0): error: perl.exe is not found. Set "perl" in "PathEnv.props" to correct perl directory (Currently: "%PERL_DIR%"). & GOTO ERR
GOTO :EOF

:CHECK_NASM
	set NASM_DIR=

	REM //Only x86, x64 require nasm
	IF NOT "%ARCH%" == "x86" IF NOT "%ARCH%" == "x64" GOTO :EOF

	set NASM_DIR=%~1\%ARCH%
	IF     EXIST "%NASM_DIR%\nasm.exe" echo PathEnv.props (5,0): warning: nasm.exe is found at "%NASM_DIR%\nasm.exe"
	IF NOT EXIST "%NASM_DIR%\nasm.exe" echo PathEnv.props (5,0): error: nasm.exe is not found. Set "nasm" in "PathEnv.props" to correct nasm directory (Currently: "%NASM_DIR%"). & GOTO ERR
GOTO :EOF


:ERR
exit /b 1
:EOF
exit /b 0
