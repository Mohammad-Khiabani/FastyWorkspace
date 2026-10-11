@echo off
setlocal enabledelayedexpansion
color 0a
title Fasty work space (v1.0.0)

rem echo Welcome message
rem echo.

rem ----/* Start Menue options *\----
:menue
cls
cls
echo +=========================================================================+
echo ^|                               Main Menue                                ^|
echo ^|-------------------------------------------------------------------------^|
echo ^|                         [1] Make new Workspace.                         ^|
echo ^|                         [2] Show Workspaces.                            ^|
echo ^|                         [3] Remove.                                     ^|
echo ^|                         ----------------------                          ^|
echo ^|                         [4] GitHub Repository.                          ^|
echo ^|                         [5] Exit.                                       ^|
echo ^|                                                                         ^|
echo +=========================================================================+

rem ----/* End Menue options *\----

echo.
set /p option=Please Enter Number Of List: 
echo.

rem ----/* Start Menue Conditions *\----

if "%option%"=="1" goto newWorkspace
if "%option%"=="2" goto showWorkspaces
if "%option%"=="3" goto removeWorkspace
if "%option%"=="4" goto gitHub
if "%option%"=="5" goto closeApp

rem ----/* Start Menue Conditions *\----

rem ----/* Start Menue Error message *\----

echo Your entered number is not defined! Please enter a number from the menu.
echo press any key to get to the menue... 
pause >nul

goto menue

rem ----/* Error Menue Error message *\----

rem ----/* Start Functions Section *\----

:gitHub
start "" "https://github.com/Mohammad-Khiabani/"
echo Press any key to return to the menue...
pause >nul
timeout /t 1 >nul
goto menue

:closeApp
echo you are at close app handler.
set /p exitQuestion=Do you want to exit? (Y = Yes, N = No): 

if /i "%exitQuestion%"=="N" goto menue

if /i "%exitQuestion%"=="Y" (
  echo Goodbye my bro :^)
  timeout /t 3
  exit
)

rem ----/* End Functions Section *\----