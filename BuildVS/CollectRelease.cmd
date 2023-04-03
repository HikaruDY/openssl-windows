@echo off

pushd "%~dp0"
	IF EXIST "x86" call :COLLECT x86
	IF EXIST "x64" call :COLLECT x64
	IF EXIST "a32" call :COLLECT a32
	IF EXIST "a64" call :COLLECT a64
popd

GOTO :EOF

:COLLECT
	set RDIR=Release_%~n1
	IF EXIST "%RDIR%" rd /s /q "%RDIR%"
	mkdir "%RDIR%"
	mkdir "%RDIR%\engines"

	copy /y "%~dp0\..\LICENSE" "%RDIR%"

	copy /y "%~1\apps\*.exe" "%RDIR%"

	copy /y "%~1\*.dll" "%RDIR%"
	copy /y "%~1\*.lib" "%RDIR%"

	copy /y "%~1\engines\*.dll" "%RDIR%\engines"
	copy /y "%~1\engines\*.lib" "%RDIR%\engines"
GOTO :EOF

:ERR
exit /b 1
:EOF
exit /b 0
