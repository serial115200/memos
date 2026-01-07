# Activate Python virtual environment (PowerShell)

$ErrorActionPreference = "Stop"

# Change to script directory
Set-Location $PSScriptRoot

if (-not (Test-Path "venv\Scripts\Activate.ps1")) {
    Write-Host "Error: Virtual environment not found!" -ForegroundColor Red
    Write-Host "Please run setup_venv.ps1 first to create the virtual environment." -ForegroundColor Yellow
    exit 1
}

& "venv\Scripts\Activate.ps1"

Write-Host "Virtual environment activated!" -ForegroundColor Green
Write-Host ""
Write-Host "You can now run:" -ForegroundColor Cyan
Write-Host "  .\make.bat html        - Build documentation" -ForegroundColor White
Write-Host "  .\make.bat livehtml    - Start live server" -ForegroundColor White
Write-Host "  .\make.bat help        - Show all available commands" -ForegroundColor White
Write-Host ""
