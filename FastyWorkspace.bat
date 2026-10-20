@ECHO off
SETLOCAL enabledelayedexpansion

:: ----/* Styles *\----
COLOR 0a
TITLE Fasty work space (v1.0.0)

:: ECHO Welcome message
:: ECHO.

:: ----/* Start Menu options *\----
:menu
CLS
ECHO +=========================================================================+
ECHO ^|                               Main Menu                                 ^|
ECHO ^|-------------------------------------------------------------------------^|
ECHO ^|                         [1] Make new Workspace.                         ^|
ECHO ^|                         ----------------------                          ^|
ECHO ^|                         [2] About.                                      ^|
ECHO ^|                         [3] GitHub Repository.                          ^|
ECHO ^|                         [4] Contact.                                    ^|
ECHO ^|                         [5] Exit.                                       ^|
ECHO ^|                                                                         ^|
ECHO +=========================================================================+

:: ----/* End Menu options *\----

ECHO.
SET /p "option= - Please Enter Number Of List: "
ECHO.

:: ----/* Start Menu Conditions *\----

IF "%option%"=="1" GOTO newWorkspace
IF "%option%"=="2" GOTO about
IF "%option%"=="3" GOTO gitHub
IF "%option%"=="4" CLS & GOTO contact
IF "%option%"=="5" GOTO closeApp

:: ----/* Start Menu Conditions *\----

:: ----/* Start Error message *\----

ECHO - Your entered number is not defined! Please enter a number from the menu.
ECHO - press any key to return to the menu... 
PAUSE >NUL

GOTO menu

:: ----/* End Error message Menu *\----

:: ----/*Start Set variables block*\----
SET "newWOrkspaceName="
:: Pattern => name:path; /Remove
SET "paths="
SET "existingPath="

SET "filePath=" 

:: ----/* End of Set variables block *\----

:: ----/* Start Functions Section *\----

:: Create a new workspace file and save the current settings into it
:saveNewWorkspace
for /f "delims=" %%I in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.FolderBrowserDialog; if ($d.ShowDialog() -eq 'OK') { $d.SelectedPath }"') do set "folderPath=%%I"
if NOT DEFINED folderPath (
  SET /p "leaveWorkspace= You didn't select any directory. Do you want to leave without saving the workspace?  (Y = Yes, N = No): "
  ECHO.
  
  IF /i "!leaveWorkspace!"=="Y" (
    GOTO menu
  ) ELSE (
    CALL :saveNewWorkspace
  )
) ELSE (
  @REM  Make new workspace file.
  >!folderPath!\%~1-FastyWorkspace.bat ECHO @ECHO OFF
  >>!folderPath!\%~1-FastyWorkspace.bat ECHO SETLOCAL ENABLEDELAYEDEXPANSION
  >>!folderPath!\%~1-FastyWorkspace.bat ECHO SET "paths=!paths!"
  TYPE "Sample_Workspace" >> "!folderPath!\%~1-FastyWorkspace.bat"

  ECHO.
  ECHO - New workspace saved successfully at this path !folderPath! :^)
  ECHO.
)
EXIT /b

::  Handler for getting the app path via the open file dialog
:getFilePath
SET "filePath=" 

:: Open a file picker dialog via PowerShell and store the selected file path
for /f "delims=" %%I in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.OpenFileDialog; if ($d.ShowDialog() -eq 'OK') { $d.FileName }"') do set "filePath=%%I"

SET "leaveWorkspace="
if NOT DEFINED filePath (
  SET /p "leaveWorkspace= You didn't select any app. Do you want to leave without saving the workspace?  (Y = Yes, N = No): "
  ECHO.
  
  IF /i "!leaveWorkspace!"=="Y" (
    GOTO menu
  ) ELSE (
    CALL :getFilePath
  )
) ELSE (
  CALL :checkExistingPath %filePath%
)
ECHO.
ECHO - Your selected app added successfully.
ECHo.
SET /p "saveWorkspace=Do you want to add another app? (Y = Yes, N = No): "
IF /i "%saveWorkspace%"=="Y" GOTO getFilePath
EXIT /b

:: Handler to check if the file path was already added
:checkExistingPath
cls
SET "appPaths=!paths!"
IF "!appPaths!"=="" SET "paths=%~1" & EXIT /b

:loop
  FOR /f "tokens=1,* delims=;" %%a IN ("!appPaths!") DO (
    IF "%%a"=="%~1" (
      ECHO.
      ECHO - This file already exists! Please select another app.
      ECHO.
      PAUSE
      CALL :getFilePath
    ) 
    IF NOT "%%b"=="" (
      SET "appPaths=%%b"
      GOTO loop
    )
    SET "paths=!paths!;%~1" 
    EXIT /b
  )
  EXIT /b
EXIT /b

:: Function for creating new workspace
:newWorkspace
set "paths="
SETLOCAL

SET /p "newWOrkspaceName= Please type the new work space name: "

CLS

ECHO - Great^^! Your workspace name is now set to '%newWorkspaceName%'.
ECHO.

ECHO - Select any key to add app path: 
PAUSE >NUL
CALL :getFilePath

CALL :saveNewWorkspace "%newWOrkspaceName%"

GOTO closeApp

:: Function for provide application information.
:about
CLS

ECHO +==========================================================================+
ECHO ^|                                                                          ^|
ECHO ^|  Hello^^! :^)                                                               ^|
ECHO ^|                                                                          ^|
ECHO ^|  Thank you so much for choosing to use my application^^!                   ^|
ECHO ^|                                                                          ^|
ECHO ^|  This is the first application I've ever built using Batch scripting.    ^|
ECHO ^|                                                                          ^|
ECHO ^|  It was originally intended for my personal use, but after completing    ^|
ECHO ^|  it, I decided to make it public and share it with others.               ^|
ECHO ^|                                                                          ^|
ECHO ^|  With this application, you can create your own workspace of frequently  ^|
ECHO ^|  used applications on your computer.                                     ^|
ECHO ^|                                                                          ^|
ECHO ^|  Whenever you need them, you can launch all your selected launch all     ^|
ECHO ^|  your selected applications with just one click, saving time and         ^|
ECHO ^|  avoiding the hassle of opening them one by one.                         ^|
ECHO ^|                                                                          ^|
ECHO ^|  By the way, you can also explore my other projects by opening the menu  ^|
ECHO ^|  and visiting my GitHub profile through the provided link.               ^|
ECHO ^|  Thanks again for giving my project a try^^!                               ^|
ECHO ^|                                                                          ^|
ECHO +==========================================================================+

ECHO.
ECHo - Press any key to return to the menu: & PAUSE >NUL

GOTO menu

:: Function to contact the developer.
:contact

ECHO.
ECHO +===============================^| Contact ^|===============================+
ECHO ^|                                                                         ^|
ECHO ^|                             [1] Instagram.                              ^|
ECHO ^|                             [2] Telegram.                               ^|
ECHO ^|                             [3] Twitter^(X^).                             ^|
ECHO ^|                             ---------------                             ^|
ECHO ^|                             [4] Main Menu.                              ^|
ECHO ^|                                                                         ^|
ECHO +=========================================================================+
ECHO.

:: Contact menu conditions
SET /p contactItem=- Press a number from the menu above, then press Enter: 
IF "%contactItem%"=="1" START "" "https://www.instagram.com/say.mhammad"
IF "%contactItem%"=="2" START "" "https://t.me/mhamad_khy"
IF "%contactItem%"=="3" START "" "https://x.com/khiabani_mh"
IF "%contactItem%"=="4" GOTO menu

CLS
ECHO.
ECHO - Please enter a valid number from the menu above.
ECHO.
TIMEOUT /t 2 >nul
GOTO contact

:: GitHub Handler
:gitHub
START "" "https://github.com/Mohammad-Khiabani/"
ECHO Press any key to return to the menu...
PAUSE >NUL
TIMEOUT /t 1 >NUL
GOTO menu

:: Close app Handler
:closeApp
SET /p exitQuestion=Do you want to exit? (Y = Yes, N = No): 

IF /i "%exitQuestion%"=="N" GOTO menu

IF /i "%exitQuestion%"=="Y" (
  GOTO exitHandler
)

CALL :alarmBox "Attention" "Please enter a valid character!"
GOTO closeApp

:: Function for showing stylized app messages
:alarmBox
ECHO.
ECHO +------------^| %~1 ^|-------------+
ECHO ^|                                      ^|
ECHO ^| -[ %~2 ]- ^|
ECHO ^|                                      ^|
ECHO +--------------------------------------+
ECHO.
EXIT /b

:: Exit app Handler
:exitHandler
ECHO Goodbye my bro :^)
TIMEOUT /t 3
EXIT

:: ----/* End Functions Section *\----