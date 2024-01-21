@echo off
setlocal enabledelayedexpansion

echo Welcome to MakeALauncher. Follow the instructions to create your own custom launcher. Use enter to submit each input.

:Start

rem Process user input for programs
echo Which programs to put in the launcher? (Separate each one with a space. Capitalization does not matter. DO NOT WRITE .exe, the program will fill that in automatically.)
set /p "search_programs="
call :trimSpaces search_programs
rem Add .exe to the end of each program
set "temp_programs="
for %%i in (%search_programs%) do (
  set "temp_programs=!temp_programs!%%i.exe "
)
set "search_programs=%temp_programs%"

rem Process user input for which drives to search
echo Which drives to search? (Type only the drive letters, each separated with a space. Leave blank to search all of them)
set /p "drive_letters="
call :trimSpaces drive_letters

rem Process user input for what to name the output file
echo What to name the output file? (If a file already exists with that name, it will be replaced. No spaces allowed.)
set /p "output_batch_file="
set "output_batch_file=%output_batch_file%.bat"
call :trimSpaces output_batch_file

rem replace drive_letters with all drives if input is empty or only spaces
if "%drive_letters%"=="" (
    set "drive_letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
)

rem Confirmation handling
echo You entered this information. Is it correct?
echo Programs to add: %search_programs%
echo Drives to search: %drive_letters%
echo Output file: %output_batch_file%

choice /C YN /M "Press Y for Yes or N to change the inputs."

if errorlevel 2 goto No
goto Continue

:No
goto Start

:Continue
rem Delete the output batch file if it already exists
if exist "%output_batch_file%" (
    del "%output_batch_file%"
    echo old %output_batch_file% deleted.
)

rem Iterate through all programs
for %%p in (%search_programs%) do (
    echo Searching for: %%p
    
    rem Iterate through all drives
    for %%d in (%drive_letters%) do (
        set "search_directory=%%d:\"
        
        rem Use dir /s /b to recursively search for the program path
        for /f "tokens=*" %%f in ('dir /s /b "!search_directory!%%p" 2^>nul') do (
            echo Found: %%f
            echo start "" "%%f" >> "%output_batch_file%"
        )
    )
)

rem Completion message
echo %output_batch_file% created. You may need to refresh the folder to make it appear.

rem Ask if user wants to launch the output file
echo Would you like to launch the output file now?
choice /C YN /M "Press Y for Yes or N for No."
if errorlevel 2 goto BeforeMakeAnother
call "%output_batch_file%"
goto EndOfProgram

:BeforeMakeAnother
rem Ask if user wants to make another launcher
echo Would you like to make another launcher?
choice /C YN /M "Press Y for Yes or N for No."
if errorlevel 2 goto EndOfProgram
goto Start

:EndOfProgram

endlocal

:trimSpaces
rem Remove leading spaces
:trimStart
if "!%1:~0,1!" == " " (
    set "%1=!%1:~1!"
    goto :trimStart
)

rem Remove trailing spaces
:trimEnd
if "!%1:~-1!" == " " (
    set "%1=!%1:~0,-1!"
    goto :trimEnd
)

goto :eof
