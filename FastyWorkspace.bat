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
ECHO ^|                         [2] Show Workspaces.                            ^|
ECHO ^|                         [3] Remove.                                     ^|
ECHO ^|                         ----------------------                          ^|
ECHO ^|                         [4] GitHub Repository.                          ^|
ECHO ^|                         [5] Exit.                                       ^|
ECHO ^|                                                                         ^|
ECHO +=========================================================================+

:: ----/* End Menue options *\----

ECHO.
SET /p "option= - Please Enter Number Of List: "
ECHO.

:: ----/* Start Menue Conditions *\----

IF "%option%"=="1" GOTO newWorkspace
IF "%option%"=="2" GOTO showWorkspaces
IF "%option%"=="3" GOTO removeWorkspace
IF "%option%"=="4" GOTO gitHub
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