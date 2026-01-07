@ECHO OFF
REM Setup Python virtual environment for Sphinx documentation

pushd %~dp0

REM Check if Python is available
python --version >NUL 2>NUL
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH
    echo Please install Python 3.8+ from https://www.python.org/
    exit /b 1
)

REM Check if venv already exists
if exist "venv\" (
    echo Virtual environment already exists at venv\
    echo.
    echo To recreate it, delete the venv\ folder first and run this script again.
    echo.
    echo Activating existing virtual environment...
    call venv\Scripts\activate.bat
    echo.
    echo Installing/updating dependencies...
    python -m pip install --upgrade pip
    pip install -r .devcontainer/requirements.txt
    echo.
    echo Setup complete! Virtual environment is now active.
    echo.
    echo To activate it in the future, run: activate_venv.bat
    echo Or manually run: venv\Scripts\activate.bat
    exit /b 0
)

echo Creating Python virtual environment...
python -m venv venv

if errorlevel 1 (
    echo Error: Failed to create virtual environment
    exit /b 1
)

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo Upgrading pip...
python -m pip install --upgrade pip

echo Installing dependencies from .devcontainer/requirements.txt...
pip install -r .devcontainer/requirements.txt

if errorlevel 1 (
    echo Error: Failed to install dependencies
    exit /b 1
)

echo.
echo ========================================
echo Setup complete!
echo ========================================
echo.
echo Virtual environment is now active.
echo.
echo To activate it in the future, run:
echo   activate_venv.bat
echo.
echo Or manually run:
echo   venv\Scripts\activate.bat
echo.
echo To build documentation, run:
echo   make.bat html
echo.
echo To start live server, run:
echo   make.bat livehtml
echo.

popd
