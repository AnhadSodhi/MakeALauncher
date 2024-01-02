@echo off
setlocal enabledelayedexpansion

echo Welcome to MakeALauncher. Follow the instructions to create your own custom launcher. Use enter to submit each input.

set /p "search_programs=Which programs to put in the launcher? (Separate each one with a space. Capitalization does not matter. DO NOT WRITE .exe, the program will fill that in automatically.) "
call :trimSpaces search_programs
rem Add .exe to the end of each program
set "temp_programs="
for %%i in (%search_programs%) do (
  set "temp_programs=!temp_programs!%%i.exe "
)
set "search_programs=%temp_programs%"

set /p "drive_letters=Which drives to search? (Type only the drive letters, each separated with a space. Leave blank to search all of them) "
call :trimSpaces drive_letters

set /p "output_batch_file=What to name the output file? (If a file already exists with that name, it will be replaced. No spaces allowed.) "
set "output_batch_file=%output_batch_file%.bat"
call :trimSpaces output_batch_file

rem replace drive_letters with all drives if input is empty or only spaces
if "%drive_letters%"=="" (
    set "drive_letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
) else if not "%drive_letters: =%"=="" (
    set "drive_letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
)

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

endlocal
pause

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