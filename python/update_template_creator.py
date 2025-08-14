import re
import sys
# Filename
import os
# Parse  arguments intelligently
import argparse
# Python Debugger
# import pdb; pdb.set_trace()

# Find the right version : ScienceTools/python/templateCreatorList.txt
TEMPLATE_FILE_LIST = os.getcwd()+"/../python/templateCreatorList.txt"

"""
Tests:
CREATOR with multiple spaces before "="
Update description,version
Update only version and description  

"""

def update_creator_line(filename, description, version, debug_mode):
    """
    Opens a file, updates the line starting with "CREATOR", and saves the file.

    Args:
        filename (str): The name of the file to modify (default: "ABC").
        new_creator_line (str): The new line to replace the existing CREATOR line (default: "CREATOR: Your New Name\n").
    """
    tools_version_text = f" 'APP_NAME {description} {version}' "


    try:
        # Read all lines from the file
        with open(filename, 'r') as file:
            lines = file.readlines()

        # Iterate through the lines and update the "CREATOR" line if found
        for line_num, line in enumerate(lines):
            # Found CREATOR parameter 
            if "CREATOR" in line:
                pattern = r"=(.*?)/"
                # Find all non-overlapping matches in the string
                matches = re.findall(pattern, line)

                # Remove any additional spaces more than one between CREATOR and '='
                creator_cleanup_line = re.sub(r"CREATOR\s+=", "CREATOR  =", line)
                new_creator_line = creator_cleanup_line
                if debug_mode :  print (f" NVL {new_creator_line} ")
                # If existing value or text exists , handle it here:
                if not matches[0].isspace() :
                    if debug_mode :  print(f"  Found 'CREATOR' on line {line_num}: {matches}")
                    # Handle an empty '' value string
                    if (matches[0].find("''") != -1):
                      new_creator_string = re.sub(r"\s''\s+", tools_version_text, line)
                      lines[line_num] = new_creator_string
                      if debug_mode : print(f"  Found '' on line {line_num}: {matches}")
                    # Handle any current filename found inside ''
                    text_pattern = r"'(.*?)'"
                    text_matches = re.findall(text_pattern, new_creator_line)
                    if debug_mode : print(f"  Found  line {line_num}: {text_matches[0]}")
                    # Handles when ONLY file name is saved as the creator
                    if description not in creator_cleanup_line:
                      delete_creator_text = creator_cleanup_line.replace( f"'{text_matches[0]}'", "     ")
                      if debug_mode :  print(f" Deleted text  {line_num}: {delete_creator_text}")
                      creator_cleanup_line = delete_creator_text
                      new_tools_text = re.sub(r"APP_NAME", text_matches[0], tools_version_text)
                      if debug_mode :  print(f"   creator_cleanup_line {creator_cleanup_line}")
                      new_creator_line = re.sub(r"\s\s\s+", new_tools_text, creator_cleanup_line)
                    else:
                      # Previous description/version text found, only update the version:
                      if version not in creator_cleanup_line:
                         ## NEED to just replace the VERSION number here!!!!!
                         version_pattern = r"(\d+)\.(\d+)\.(\d+)"
                         # Replace all occurrences of the pattern
                         new_creator_line = re.sub(version_pattern, version, creator_cleanup_line)

                else:
                   new_creator_line = re.sub(r"\s\s\s+", tools_version_text, creator_cleanup_line )
                lines[line_num] = new_creator_line

        # Write the modified content back to the file
        with open(filename, 'w') as file:
            file.writelines(lines)

        print(f"File '{filename}' updated successfully.")

    except FileNotFoundError:
        print(f"Error: Opening File '{filename}' not found.")
    except Exception as e:
        print(f"An error occurred: {e}")


def update_creator_in_templates(paths_file, description, version , debug_mode ):
    """
    Handle the open/processing of the template list file

    Reads file paths from a given file and finds lines containing "CREATOR"
    in each of those files.

    Args:
        paths_file (str): The path to the file containing a list of file paths.
    """
    try:
        with open(paths_file, 'r') as f_paths:
            file_paths = [line.strip() for line in f_paths if line.strip()]

        for file_path in file_paths:
            full_file_path = os.getcwd()+"/../"+file_path
            print(f"Searching in file: {full_file_path}")
            update_creator_line(full_file_path, description, version, debug_mode)

    except FileNotFoundError:
        print(f"Error: Process Paths file '{paths_file}' not found.")
    except Exception as e:
        print(f"Error reading paths file: {e}")


if __name__ == "__main__" :
   # Get the full path to the current script
   # Always knows what the script name is...
   script_path = __file__
   debug_code = False

   # Extract the filename from the full path
   script_name = os.path.basename(script_path)
   num_args = len(sys.argv) 

   # Check if the correct number of arguments is provided
   if num_args !=  3:
      print(f"Usage: python3  {script_name} <description> <version number>")
      sys.exit(1) # Exit with an error code

   parser = argparse.ArgumentParser(description='Scripti to update known template files with group description/version before cmake compilation.')
   parser.add_argument('description', type=str, help='description/group string')
   parser.add_argument('version', type=str, help='version number')
   args = parser.parse_args()

   print(f"Got group {args.description}, version {args.version} .")

   # List of current templates to update
   update_creator_in_templates(TEMPLATE_FILE_LIST, args.description, args.version, debug_code)
