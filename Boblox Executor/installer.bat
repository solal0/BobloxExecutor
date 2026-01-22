@echo off
setlocal EnableDelayedExpansion

set TARGET_DIR=%~dp0
set TARGET_DIR=%TARGET_DIR:~0,-1%
set DLL_PATH=%TARGET_DIR%\wearedevs_exploit_api.dll

set URLS[0]=https://github.com/wcrddn/wcrddn.github.io/raw/refs/heads/main/121725/wearedevs_exploit_api.dll
set URLS[1]=https://api.websim.com/blobs/019be32f-7785-7209-b0f5-5e0e8f8dc676.dll
set URLS[2]=https://api.websim.com/blobs/019be32f-d0a1-755a-89de-292b0b9f3c27.dll
set URLS[3]=https://api.websim.com/blobs/019be330-0cac-752f-8fb1-c057f9972b2f.dll
set URLS[4]=https://api.websim.com/blobs/019be330-4138-76e2-baa3-f00471ed5ccb.dll
set URLS[5]=https://api.websim.com/blobs/019be330-6ffa-77fc-a81d-b3fc8328c4f7.dll

set SUCCESS=0

for /L %%I in (0,1,5) do (
    if !SUCCESS! EQU 0 (
        call :tryDownload "!URLS[%%I]!"
    )
)

if !SUCCESS! EQU 0 (
    powershell -NoProfile -Command ^
    "Add-Type -AssemblyName System.Windows.Forms; ^
     [System.Windows.Forms.MessageBox]::Show( ^
        'The api couldn''t be downloaded, join the discord to request help.', ^
        'Error', ^
        [System.Windows.Forms.MessageBoxButtons]::OK, ^
        [System.Windows.Forms.MessageBoxIcon]::Error ^
     ) | Out-Null"
)

endlocal
exit /b

:tryDownload
curl -f -L "%~1" -o "%DLL_PATH%" >nul 2>&1
if %ERRORLEVEL% EQU 0 set SUCCESS=1
exit /b
