@ECHO off
SETLOCAL enabledelayedexpansion

:: ----/* Styles *\----
COLOR 0a
TITLE Fasty work space (v1.0.0)

:: ECHO Welcome message
:: ECHO.

:: ----/* Start Menue options *\----
:menue
CLS
ECHO +=========================================================================+
ECHO ^|                               Main Menue                                ^|
ECHO ^|-------------------------------------------------------------------------^|
ECHO ^|                         [1] Make new Workspace.                         ^|
ECHO ^|                         ----------------------                          ^|
ECHO ^|                         [2] About.                                      ^|
ECHO ^|                         [3] GitHub Repository.                          ^|
ECHO ^|                         [4] Contact.                                    ^|
ECHO ^|                         [5] Exit.                                       ^|
ECHO ^|                                                                         ^|
ECHO +=========================================================================+

:: ----/* End Menue options *\----

ECHO.
SET /p "option= - Please Enter Number Of List: "
ECHO.

:: ----/* Start Menue Conditions *\----

IF "%option%"=="1" GOTO newWorkspace
IF "%option%"=="2" GOTO about
IF "%option%"=="3" GOTO gitHub
IF "%option%"=="4" GOTO contact
IF "%option%"=="5" GOTO closeApp

:: ----/* Start Menue Conditions *\----

:: ----/* Start Error message *\----

ECHO - Your entered number is not defined! Please enter a number from the menu.
ECHO - press any key to return to the menue... 
PAUSE >NUL

GOTO menue

:: ----/* End Error message Menue *\----

:: ----/*Start Set variables block*\----
SET "newWOrkspaceName="
:: Pattern => name:path; /Remove
SET "paths="
SET "existingPath="

SET "filePath=" 

:: ----/* End of Set variables block *\----

:: ----/* Start Functions Section *\----

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
    GOTO menue
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

:: GitHub Handler
:gitHub
START "" "https://github.com/Mohammad-Khiabani/"
ECHO Press any key to return to the menue...
PAUSE >NUL
TIMEOUT /t 1 >NUL
GOTO menue

:: Close app Handler
:closeApp
SET /p exitQuestion=Do you want to exit? (Y = Yes, N = No): 

IF /i "%exitQuestion%"=="N" GOTO menue

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