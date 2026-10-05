@echo off

rem echo Welcome message
rem echo.

rem ----/* Start Menue options *\----
:menue
cls
echo ======================
echo [1] Make new Workspace
echo [2] Show Workspaces
echo [3] Remove 
echo ---------------------
echo [4] GitHub Repository
echo [5] Exit
echo ======================

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

