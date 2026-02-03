@ECHO OFF

pushd %~dp0

REM Command file for Sphinx documentation

REM Check if venv exists and use it if available
if exist "venv\Scripts\sphinx-build.exe" (
	set SPHINXBUILD=venv\Scripts\sphinx-build.exe
	set SPHINXAUTOBUILD=venv\Scripts\sphinx-autobuild.exe
) else if "%SPHINXBUILD%" == "" (
	set SPHINXBUILD=sphinx-build
	set SPHINXAUTOBUILD=sphinx-autobuild
)

set SOURCEDIR=source
set BUILDDIR=build

REM Check if sphinx-build is available
%SPHINXBUILD% >NUL 2>NUL
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-build' command was not found. Make sure you have Sphinx
	echo.installed, then set the SPHINXBUILD environment variable to point
	echo.to the full path of the 'sphinx-build' executable. Alternatively you
	echo.may add the Sphinx directory to PATH.
	echo.
	echo.If you don't have Sphinx installed, grab it from
	echo.https://www.sphinx-doc.org/
	echo.
	echo.Or run setup_venv.bat to create a Python virtual environment.
	exit /b 1
)

if "%1" == "" goto help
if "%1" == "livehtml" goto livehtml

%SPHINXBUILD% -M %1 %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %O%
goto end

:livehtml
REM Check if sphinx-autobuild is available
%SPHINXAUTOBUILD% >NUL 2>NUL
if errorlevel 9009 (
	echo.
	echo.The 'sphinx-autobuild' command was not found. Make sure you have
	echo.sphinx-autobuild installed in your virtual environment.
	echo.
	echo.Run setup_venv.bat to install all dependencies.
	exit /b 1
)
REM Note: --ignore patterns are relative to SOURCEDIR
REM --host 0.0.0.0 允许局域网内其他设备访问
%SPHINXAUTOBUILD% --host 0.0.0.0 %SOURCEDIR% %BUILDDIR%\html %SPHINXOPTS% %O%
goto end

:help
%SPHINXBUILD% -M help %SOURCEDIR% %BUILDDIR% %SPHINXOPTS% %O%

:end
popd
