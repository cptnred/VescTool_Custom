# Cleanup all build artifacts before transferring to Linux VM

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Cleaning Build Artifacts" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Removing build directories..." -ForegroundColor Yellow
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue build, release, debug

Write-Host "Removing Qt build files..." -ForegroundColor Yellow
Remove-Item -Force -ErrorAction SilentlyContinue .qmake.stash, Makefile*, object_script.*

Write-Host "Removing compiled objects..." -ForegroundColor Yellow
Get-ChildItem -Recurse -Include "*.o","*.obj","moc_*","ui_*","qrc_*" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

Write-Host "Removing Android library files..." -ForegroundColor Yellow
Remove-Item -Force -ErrorAction SilentlyContinue libvesc_tool*.so

Write-Host "Removing Android deployment file..." -ForegroundColor Yellow
Remove-Item -Force -ErrorAction SilentlyContinue android-vesc_tool-deployment-settings.json

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host " Cleanup Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Project is now clean and ready for Linux VM transfer." -ForegroundColor Cyan
Write-Host ""
