# Build script for Custom VESC Tool version (Windows)
# This script builds the custom version of VESC Tool with optional mobile UI

param(
    [switch]$ExcludeFW = $false,
    [switch]$IncludeMobile = $false
)

Write-Host "=== Building Custom VESC Tool ===" -ForegroundColor Green

# Mobile folder swap flag
$mobileSwapped = $false

# Check if qmake is in PATH
if (!(Get-Command qmake -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: qmake not found in PATH!" -ForegroundColor Red
    Write-Host "Please add Qt bin directory to PATH, e.g.:" -ForegroundColor Yellow
    Write-Host '  $env:PATH = "C:\Qt\5.15.2\mingw81_64\bin;$env:PATH"' -ForegroundColor Yellow
    exit 1
}

# Check if make/mingw32-make is available
$make_cmd = if (Get-Command mingw32-make -ErrorAction SilentlyContinue) { "mingw32-make" } 
           elseif (Get-Command make -ErrorAction SilentlyContinue) { "make" }
           else { $null }

if (!$make_cmd) {
    Write-Host "ERROR: Neither mingw32-make nor make found in PATH!" -ForegroundColor Red
    exit 1
}

# Prepare build directory
Write-Host "Cleaning previous build..." -ForegroundColor Cyan
if (Test-Path "build/win") {
    Remove-Item -Recurse -Force "build/win/*"
}

# Mobile UI folder swap if requested
if ($IncludeMobile) {
    Write-Host "Setting up Custom Mobile UI..." -ForegroundColor Cyan
    
    # Check if mobile_custom exists
    if (!(Test-Path "mobile_custom")) {
        Write-Host "ERROR: mobile_custom folder not found!" -ForegroundColor Red
        exit 1
    }
    
    # Backup original mobile folder if it exists
    if (Test-Path "mobile") {
        if (Test-Path "mobile_original") {
            Write-Host "WARNING: mobile_original already exists, removing it..." -ForegroundColor Yellow
            Remove-Item -Recurse -Force "mobile_original"
        }
        Write-Host "  Backing up: mobile -> mobile_original" -ForegroundColor Gray
        Rename-Item "mobile" "mobile_original"
    }
    
    # Activate custom mobile folder
    Write-Host "  Activating: mobile_custom -> mobile" -ForegroundColor Gray
    Copy-Item -Recurse "mobile_custom" "mobile"
    $mobileSwapped = $true
}

# Configure build options
$config_options = "CONFIG+=build_custom"
if ($ExcludeFW) {
    $config_options += " exclude_fw"
    Write-Host "Building without firmware files (faster)" -ForegroundColor Yellow
}
if ($IncludeMobile) {
    $config_options += " build_mobile"
    Write-Host "Building with Custom Mobile UI" -ForegroundColor Yellow
}

try {
    # Run qmake
    Write-Host "Running qmake..." -ForegroundColor Cyan
    qmake -config release $config_options

    if ($LASTEXITCODE -ne 0) {
        throw "qmake failed!"
    }

    # Run make
    Write-Host "Compiling (using $make_cmd)..." -ForegroundColor Cyan
    & $make_cmd -j8

    if ($LASTEXITCODE -ne 0) {
        throw "Compilation failed!"
    }
}
finally {
    # Restore mobile folders if swapped (even on error!)
    if ($mobileSwapped) {
        Write-Host "Restoring original mobile folders..." -ForegroundColor Cyan
        
        if (Test-Path "mobile") {
            Remove-Item -Recurse -Force "mobile"
            Write-Host "  Removed temporary mobile folder" -ForegroundColor Gray
        }
        
        if (Test-Path "mobile_original") {
            Rename-Item "mobile_original" "mobile"
            Write-Host "  Restored: mobile_original -> mobile" -ForegroundColor Gray
        }
    }
}

Write-Host ""
Write-Host "=== Build Successful! ===" -ForegroundColor Green
Write-Host "Executable location: build/win/vesc_tool_6.06.exe" -ForegroundColor Green
Write-Host ""
Write-Host "To run: .\build\win\vesc_tool_6.06.exe" -ForegroundColor Cyan
