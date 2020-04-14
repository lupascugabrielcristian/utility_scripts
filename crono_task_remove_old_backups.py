#!/usr/bin/python3.6
import os
import platform

### SETTINGS ########## 
how_many_to_keep = 2
zip_files_location = "/home/gabi/projects/utility_scripts/utility_scripts/"
#######################

def creation_date(path_to_file):
    """
    Try to get the date that a file was created, falling back to when it was
    last modified if that isn't possible.
    See http://stackoverflow.com/a/39501288/1709587 for explanation.
    """
    stat = os.stat(path_to_file)
    try:
        return stat.st_birthtime
    except AttributeError:
        return stat.st_mtime


def get_zip_files(zip_folder_path):
    zip_files = []
    for ( dirpath, dirnames, filenames ) in os.walk(zip_folder_path):
        zip_files.extend(filenames)
    zip_files = list(filter(lambda f: ".zip" in f  and "2020" in f , zip_files ) )
    return zip_files



# Gets only the names of the zip files
zip_files = get_zip_files(zip_files_location) 
zip_files = list(map(lambda zip_file: zip_files_location + zip_file, zip_files))

# The newest will be first
zip_files.sort(key=creation_date, reverse=True)

# Removing
if len(zip_files) <= how_many_to_keep:
    exit(0)
for i in range (how_many_to_keep, len(zip_files)):
    print("delete " + zip_files[i])
    os.remove(zip_files[i])

