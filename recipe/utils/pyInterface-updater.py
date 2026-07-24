##################################################################################  
#
# This script finds and replaces specific object calls
# within a provided script in order to allow compatibility
# with Fermitools release 2.5.2 (released 29 July 2026).
#
# The script checks for the version of the Fermitools installed
# within the conda environment it is run in and will apply updates
# if applicable.
#
# If the replace flag is passed, the script will replace the target script
# with the updated one.  Otherwise the script will make a copy of the target
# with the name <name>.bak.  Creating a copy is the default
# for safety reasons.
#
# A text list of files can be provided using the @<listname> format.
#
# Usage: python pyInterface-updater.py
#
# J. Asercion 20 July 2026
# FSSC
#
##################################################################################

import argparse
import difflib
import fileinput
import os
import subprocess
import sys

# list of calls to update:
calls = {'AppHelpers_checkExposureMap':'AppHelpers.checkExposureMap',
         'AppHelpers_checkCuts':'AppHelpers.checkCuts',
         'AppHelpers_checkTimeCuts':'AppHelpers.checkTimeCuts',
         'AppHelpers_checkExpMapCuts':'AppHelpers.checkExpMapCuts',
         'FileFunction_cast':'FileFunction.cast',
         'OptimizerFactory_instance':'OptimizerFactory.instance',
         'Loader_go':'Loader.go',
         'Util_resolveFitsFiles':'Util.resolveFitsFiles',
         'SourceFactory_funcFactory':'SourceFactory.funcFactory'}

def parse_version(fermitoolsversion):
    return tuple(int(x) for x in fermitoolsversion.split("."))

if __name__ == "__main__":

    # Create argparser and grab inputs
    parser = argparse.ArgumentParser(description="Fermitools 2.5.X python compatibility update script")
    parser.add_argument("-t", "--target", type=str, help="Script to update")
    parser.add_argument("-r", "--replace", action="store_true", help="Enable replacement of target script")

    args = parser.parse_args()
    
    if args.target == None:
        target = input("Target Script: ")
    else:
        target = args.target

    # Load files into list
    filelist = []
    if target[0] == "@":
        # Filelist provided
        with open(target[1:], "r") as file:
            filelist = [line.rstrip() for line in file]
    else:
        filelist = [target]

    # Check Fermitools version
    fermitoolsversion = subprocess.run(["conda list fermitools --full-name | awk '!/^#/ {print $2}'"], capture_output=True, text=True, shell=True).stdout.strip()
    print("Fermitools Version Detected: ", fermitoolsversion)
    if parse_version("2.5.2") > parse_version(fermitoolsversion):
        sys.exit(f"Installed Fermitools {fermitoolsversion} < 2.5.2.  Terminating script.")

    replace = args.replace

    # statistics
    numchanges = 0
    numfiles = 0

    for filename in filelist:
        filechanged = 0
        if replace == False:
            backupext = ".bak"
        else:
            backupext = ''

        print(f"Updating {filename}...")
        print('*' * (len(filename)+12))
            
        with fileinput.FileInput(filename, inplace=True, backup=backupext) as file:
            for line_number, line in enumerate(file, start=1):
                original_line = line
                for old_case, new_case in calls.items():
                    line = line.replace(old_case, new_case)
                if original_line != line:
                    filechanged = 1
                    numchanges+=1
                    print(f"line: {line_number}", file=sys.stderr)
                    diff = difflib.ndiff(original_line.splitlines(), line.splitlines())
                    print('     '+'\n     '.join(diff), file=sys.stderr)
                print(line, end="")
        if filechanged == 1:
            numfiles += 1

    print("pyLikelihood 2.5.x compatibility updates complete.")
    if replace == False:
        print("File backups saved as <filename>.bak")
    print(f"{numchanges} changes made in {numfiles} files.")
    
        
    
    
