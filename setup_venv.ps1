# Setup Python virtual environment for Sphinx documentation (PowerShell)

$ErrorActionPreference = "Stop"

# Change to script directory
Set-Location $PSScriptRoot

# Check if Python is available
try {
    $pythonVersion = python --version 2>&1
    Write-Host "Found Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Python is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Python 3.8+ from https://www.python.org/" -ForegroundColor Yellow
    exit 1
}

# Check if venv already exists
if (Test-Path "venv") {
    Write-Host "Virtual environment already exists at venv\" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To recreate it, delete the venv\ folder first and run this script again." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Activating existing virtual environment..." -ForegroundColor Cyan

    & "venv\Scripts\Activate.ps1"

    Write-Host ""
    Write-Host "Installing/updating dependencies..." -ForegroundColor Cyan
    python -m pip install --upgrade pip
    pip install -r .devcontainer/requirements.txt

    Write-Host ""
    Write-Host "Setup complete! Virtual environment is now active." -ForegroundColor Green
    Write-Host ""
    Write-Host "To activate it in the future, run: .\activate_venv.ps1" -ForegroundColor Cyan
    Write-Host "Or manually run: .\venv\Scripts\Activate.ps1" -ForegroundColor Cyan
    exit 0
}

Write-Host "Creating Python virtual environment..." -ForegroundColor Cyan
python -m venv venv

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to create virtual environment" -ForegroundColor Red
    exit 1
}

Write-Host "Activating virtual environment..." -ForegroundColor Cyan
& "venv\Scripts\Activate.ps1"

Write-Host "Upgrading pip..." -ForegroundColor Cyan
python -m pip install --upgrade pip

Write-Host "Installing dependencies from .devcontainer/requirements.txt..." -ForegroundColor Cyan
pip install -r .devcontainer/requirements.txt

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to install dependencies" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Virtual environment is now active." -ForegroundColor Green
Write-Host ""
Write-Host "To activate it in the future, run:" -ForegroundColor Cyan
Write-Host "  .\activate_venv.ps1" -ForegroundColor White
Write-Host ""
Write-Host "Or manually run:" -ForegroundColor Cyan
Write-Host "  .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host ""
Write-Host "To build documentation, run:" -ForegroundColor Cyan
Write-Host "  .\make.bat html" -ForegroundColor White
Write-Host ""
Write-Host "To start live server, run:" -ForegroundColor Cyan
Write-Host "  .\make.bat livehtml" -ForegroundColor White
Write-Host ""
