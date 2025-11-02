# Build script for Custom VESC Tool - Windows Desktop Version
# This builds a Windows .exe with your custom features and logo

param(
    [switch]$ExcludeFW = $false,
    [string]$QtPath = "C:\Qt\5.15.2\mingw81_64",
    [string]$MinGWPath = "C:\Qt\Tools\mingw810_64"
)

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " VESC Tool Custom - Windows Desktop Build" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check Qt installation
if (!(Test-Path "$QtPath\bin\qmake.exe")) {
    Write-Host "ERROR: Qt not found at: $QtPath" -ForegroundColor Red
    Write-Host "Please install Qt 5.15.2 with MinGW or specify path with -QtPath" -ForegroundColor Yellow
    exit 1
}

# Check mingw32-make
if (!(Test-Path "$MinGWPath\bin\mingw32-make.exe")) {
    Write-Host "ERROR: mingw32-make not found at: $MinGWPath\bin" -ForegroundColor Red
    Write-Host "Please specify MinGW path with -MinGWPath" -ForegroundColor Yellow
    exit 1
}

Write-Host "Using Qt from: $QtPath" -ForegroundColor Gray
Write-Host "Using MinGW from: $MinGWPath" -ForegroundColor Gray
Write-Host ""

# Set Qt and MinGW in PATH
$env:PATH = "$QtPath\bin;$MinGWPath\bin;$env:PATH"

# Clean old build files
Write-Host "Cleaning previous build..." -ForegroundColor Yellow
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue .qmake.stash, Makefile*, object_script.*, build/win
Get-ChildItem -Recurse -Include "*.o","*.obj","moc_*","ui_*","qrc_*" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

# Prepare build directory
New-Item -ItemType Directory -Force -Path "build/win" | Out-Null

# Configure build options
$config_options = "CONFIG+=build_custom"
if ($ExcludeFW) {
    $config_options += " exclude_fw"
    Write-Host "Building without firmware files (smaller, faster)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Build Configuration: $config_options" -ForegroundColor Cyan
Write-Host ""

try {
    # Run qmake
    Write-Host "Running qmake..." -ForegroundColor Cyan
    & "$QtPath\bin\qmake.exe" -config release $config_options

    if ($LASTEXITCODE -ne 0) {
        throw "qmake failed with exit code $LASTEXITCODE"
    }

    Write-Host ""
    Write-Host "Compiling (this may take 5-10 minutes)..." -ForegroundColor Cyan
    $startTime = Get-Date
    
    & "$MinGWPath\bin\mingw32-make.exe" -j8

    if ($LASTEXITCODE -ne 0) {
        throw "Compilation failed with exit code $LASTEXITCODE"
    }

    $duration = (Get-Date) - $startTime
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Green
    Write-Host " BUILD SUCCESSFUL!" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Build time: $([math]::Round($duration.TotalMinutes, 1)) minutes" -ForegroundColor Cyan
    Write-Host "Executable: build\win\vesc_tool_6.06.exe" -ForegroundColor Cyan
    
    if (Test-Path "build\win\vesc_tool_6.06.exe") {
        $fileSize = (Get-Item "build\win\vesc_tool_6.06.exe").Length / 1MB
        Write-Host "File size: $([math]::Round($fileSize, 1)) MB" -ForegroundColor Cyan
    }
    
    Write-Host ""
    Write-Host "To run: .\build\win\vesc_tool_6.06.exe" -ForegroundColor Yellow
    Write-Host ""
}
catch {
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Red
    Write-Host " BUILD FAILED!" -ForegroundColor Red
    Write-Host "============================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host ""
    exit 1
}
