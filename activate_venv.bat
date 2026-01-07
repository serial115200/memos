@ECHO OFF
REM Activate Python virtual environment

pushd %~dp0

if not exist "venv\Scripts\activate.bat" (
    echo Error: Virtual environment not found!
    echo Please run setup_venv.bat first to create the virtual environment.
    exit /b 1
)

call venv\Scripts\activate.bat

echo Virtual environment activated!
echo.
echo You can now run:
echo   make.bat html        - Build documentation
echo   make.bat livehtml    - Start live server
echo   make.bat help        - Show all available commands
echo.

popd
