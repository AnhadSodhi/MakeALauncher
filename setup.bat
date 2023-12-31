@echo off
setlocal enabledelayedexpansion

echo Welcome to MakeALauncher. Follow the instructions to create your own custom launcher.
set /p "search_programs=Which programs to put in the launcher? (Separate each one with a space. Capitalization does not matter. Make sure they each end with .exe) "
set /p "drive_letters=Which drives to search? (Type only the drive letters, each separated with a space. Leave blank to search all of them) "
set /p "output_batch_file=What to name the output file? (If a file already exists with that name, it will be replaced. No spaces allowed. Make sure it ends with .bat) "

rem replace drive_letters with all drives if input is empty or only spaces
if "%drive_letters%"=="" (
    set "drive_letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
) else if not "%myVariable: =%"=="" (
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
echo %output_batch_file% created. You may need to refresh the folder to make it appear.

endlocal
pause