#!/bin/bash

echo "Welcome to MakeALauncher. Follow the instructions to create your own custom launcher. Use enter to submit each input."

while true; do
    # Process user input for programs
    read -p "Which programs to put in the launcher? (Separate each one with a space. Capitalization does not matter. Remember to write the file extension.): " search_programs
    search_programs=$(echo "$search_programs" | tr -d ' ')

    # Process user input for which drives to search
    read -p "Which drives to search? (Type only the drive letters, each separated with a space. Leave blank to search all of them): " drive_letters
    drive_letters=$(echo "$drive_letters" | tr -d ' ')

    # Process user input for what to name the output file
    read -p "What to name the output file? (If a file already exists with that name, it will be replaced. No spaces allowed.): " output_file
    output_file="$output_file.sh"
    output_file=$(echo "$output_file" | tr -d ' ')

    # Replace drive_letters with all drives if input is empty or only spaces
    if [ -z "$drive_letters" ]; then
        drive_letters="A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
    fi

    # Confirmation handling
    echo "You entered this information. Is it correct?"
    echo "Programs to add: $search_programs"
    echo "Drives to search: $drive_letters"
    echo "Output file: $output_file"

    read -p "Press Enter to continue, or type 'N' to change the inputs: " confirmation

    if [ "$confirmation" == "N" ] || [ "$confirmation" == "n" ]; then
        continue
    fi

    # Delete the output batch file if it already exists
    if [ -e "$output_file" ]; then
        rm "$output_file"
        echo "Old $output_file deleted."
    fi

    # Iterate through all programs
    for program in $search_programs; do
        echo "Searching for: $program"

        # Iterate through all drives
        for drive in $drive_letters; do
            search_directory="/Volumes/$drive/"
            
            # Use find to recursively search for the program path
            find "$search_directory" -name "$program" -type d -exec echo "Found: {}" \; -exec echo "open -a {}" \; >> "$output_file"
        done
    done

    # Completion message
    echo "$output_file created. You may need to refresh the folder to make it appear."

    # Ask if the user wants to launch the output file
    read -p "Would you like to launch the output file now? (Y/N): " launch_choice
    if [ "$launch_choice" == "Y" ] || [ "$launch_choice" == "y" ]; then
        chmod +x "$output_file"
        ./"$output_file"
    fi

    # Ask if the user wants to make another launcher
    read -p "Would you like to make another launcher? (Y/N): " another_launcher
    if [ "$another_launcher" != "Y" ] && [ "$another_launcher" != "y" ]; then
        break
    fi
done
