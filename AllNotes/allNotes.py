# Create class for holding file, extension and appropriate command to run

import os, sys
import subprocess
from subprocess import call


notesDirectory = "/home/cristi/Documents/notes/"
booksDirectory = "/home/cristi/Documents/Books/"
pythonBooksDirectory = "/home/cristi/Documents/Books/PythonBundle/"
xmindLocation = "/home/cristi/Downloads/xmind-8-update8-linux/XMind_amd64/"

class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def chooseFile(files):
    counter = 0
    if len(files) == 0:
        return None
    for f in files:
        print ("%s %d %s %s %s" %(colors.WARNING, counter, colors.OKGREEN, f, colors.ENDC) )
        counter = counter + 1
    answer = input("Which one?[Enter to continue] ")
    result = None
    if len(answer) == 0:
        return result
    
    answer = int(answer)
    if answer < 0 or answer > len(files) - 1:
        print("Incorrect option")
    else:
        result = files[answer]
    return result

def filterFilesAfterArgument(files):
    return list(filter(lambda f: f.lower().find(sys.argv[1]) != -1, files))

def openChosenOption(fileFound):
    dotPosition = fileFound.find('.') + 1
    extension = fileFound[dotPosition:]
    if extension == "pdf":
        call(["evince", booksDirectory + fileFound])
    elif extension == "txt" or extension == "md":
        call(["nvim", notesDirectory + fileFound])
    elif extension == "xmind":
        call(["XMind", notesDirectory + fileFound])
    elif extension == "dia":
        call(["dia", notesDirectory + fileFound])
    elif extension == "gv":
        call(["vimdot", notesDirectory + fileFound])

def searchOnline(searchTextParts):
    searchText = '+'.join(searchTextParts)
    googleSearchPage="https://www.google.com/search?client=ubuntu&channel=fs&q="
    input("Search online for %s?" % searchText)
    call(["w3m", googleSearchPage+searchText])

if len(sys.argv) == 1:
    print("There are not enough arguments")
    sys.exit(1)

files = os.listdir(notesDirectory)
files = files + os.listdir(booksDirectory)
files = files + os.listdir(pythonBooksDirectory)

files = filterFilesAfterArgument(files)

try:
    chosenFile = chooseFile(files)
    if chosenFile is None:
        searchOnline(sys.argv[1:])
    else:
        openChosenOption(chosenFile)
except KeyboardInterrupt:
    print("\nUser interrupted")
    sys.exit(0)



