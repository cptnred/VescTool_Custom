# Deploy Qt DLLs to release folder

Write-Host "Copying Qt DLLs..." -ForegroundColor Cyan

# Copy Qt DLLs
Copy-Item "C:\Qt\5.15.2\mingw81_64\bin\Qt5*.dll" "release\" -Force
Write-Host "  Qt5 DLLs copied" -ForegroundColor Gray

# Copy platforms plugin
Copy-Item -Recurse "C:\Qt\5.15.2\mingw81_64\plugins\platforms" "release\" -Force
Write-Host "  Platforms plugin copied" -ForegroundColor Gray

# Copy MinGW runtime DLLs
Copy-Item "C:\Qt\Tools\mingw810_64\bin\libgcc*.dll" "release\" -Force
Copy-Item "C:\Qt\Tools\mingw810_64\bin\libstdc*.dll" "release\" -Force
Copy-Item "C:\Qt\Tools\mingw810_64\bin\libwinpthread*.dll" "release\" -Force
Write-Host "  MinGW runtime DLLs copied" -ForegroundColor Gray

Write-Host ""
Write-Host "Done! Now try running: .\release\vesc_tool_6.06.exe" -ForegroundColor Green
