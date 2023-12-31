# MakeALauncher
A simple program that lets the user create a file that launches multiple programs with just one click. Just put in the names of the programs you want, and let setup.bat do the rest. You don't even need the file paths!

## Usage instructions
* Download and launch setup.bat.
* It will prompt you for the names of the programs you wish to add to the launcher, the drives to search, and the name of the output file. Enter them in as they appear.
* The program will scan your computer for the locations of those programs and add them to the output file.
* The computer will display a message once it is finished. Click anywhere to close that window.
* That's it! You now have your very own custom launcher.

## Tips
* Abort the setup at any time using Ctrl+C. If this is during the 'searching for programs' phase, this will cause the output file to be incomplete. Delete it and try again, or run setup.bat again using the same name to overwrite the old launcher file.
* If you changed the locations of your programs after running setup, have no fear! Simply run setup.bat again and it will give you a new, updated output file.
* It may take some time to find each program, especially if you have a lot of files or are using a hard drive.

## Feel free to open an issue ticket (in the top menu) if you have any problems or questions!

<sub>Most of this code was taken from my other project, BakkesLeague Launcher (https://github.com/frost-ee/BakkesLeague-Launcher). I wanted to make a version that wasn't hard-coded and instead let the user decide which programs to add to the output file. Again, I had some assistance from ChatGPT 3.5 (December 30/31, 2023)</sub>
