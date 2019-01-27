# Create FoundResult class for holding file, extension and appropriate command to run

import os, sys
import subprocess
from subprocess import call
from  search_mongo_note import searchAllNotes

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

class FoundResult:
    UNKNOWN_APPLICATION = "unknown_application"
    WITHOUT_EXTENSION = "without_extension"

    def __init__(self, what):
        self.application = FoundResult.UNKNOWN_APPLICATION
        self.extension = FoundResult.WITHOUT_EXTENSION
        self.what = what
        self.where = ""


def chooseFile(foundResults):
    counter = 0
    if len(foundResults) == 0:
        return None
    for f in foundResults:
        print ("%s %d %s %s %s" %(colors.WARNING, counter, colors.OKGREEN, f.what, colors.ENDC) )
        counter = counter + 1
    answer = input("Which one?[Enter to continue] ")
    
    result = None
    if len(answer) == 0:
        return result
    
    answer = int(answer)
    if answer < 0 or answer > len(foundResults) - 1:
        print("Incorrect option")
    else:
        result = foundResults[answer]
    return result

def filterFilesAfterArgument(files):
    return list(filter(lambda f: f.lower().find(sys.argv[1]) != -1, files))

def fileToFoundResult(fileFound):
    result = FoundResult(fileFound)
    dotPosition = fileFound.find('.') + 1
    extension = fileFound[dotPosition:]
    result.extension = extension
    result.where = notesDirectory
    if extension == "pdf":
        result.application = "evince"
        result.where = booksDirectory
        if os.path.exists(pythonBooksDirectory + result.what):
            result.where = pythonBooksDirectory
    elif extension == "txt" or extension == "md":
        result.application = "nvim"
    elif extension == "xmind":
        result.application = "XMind"
    elif extension == "dia":
        result.application = "dia"
    elif extension == "gv":
        result.application = "vimdot"
    return result


def openChosenOption(foundResult):
    if foundResult.application == FoundResult.UNKNOWN_APPLICATION:
        os.system("xclip -sel clip < " + foundResult.what)
        print("Copied to clipboard")
    if foundResult.application == "w3m":
        call([foundResult.application, foundResult.what])
    else:
        call([foundResult.application, foundResult.where + foundResult.what])

def searchOnline(searchTextParts):
    searchText = '+'.join(searchTextParts)
    googleSearchPage="https://www.google.com/search?client=ubuntu&channel=fs&q="
    input("Search online for %s?" % searchText)
    call(["w3m", googleSearchPage+searchText])

def mergeNotesContents(notes):
    allContents = []
    for n in notes:
        allContents += n.contents;
    return allContents

def createResultFromMongoContent(content):
    result = FoundResult(content)
    if content.find("http") != -1:
        result.application = "w3m"
    else:
        result.application = FoundResult.UNKNOWN_APPLICATION
    return result

def searchMongoNotes(forWhat):
    mongoNotes = searchAllNotes(forWhat)
    mongoNotesContents = mergeNotesContents(mongoNotes);
    return list( map( lambda c: createResultFromMongoContent(c), mongoNotesContents ) )

def searchFiles():
    files = os.listdir(notesDirectory)
    files = files + os.listdir(booksDirectory)
    files = files + os.listdir(pythonBooksDirectory)
    files = filterFilesAfterArgument(files)
    return list( map( lambda f: fileToFoundResult(f), files ) )

if len(sys.argv) == 1:
    print("There are not enough arguments")
    sys.exit(1)

## Starts here
allResults = searchFiles() + \
             searchMongoNotes(sys.argv[1]) 

try:
    chosenFile = chooseFile(allResults)
    if chosenFile is None:
        searchOnline(sys.argv[1:])
    else:
        openChosenOption(chosenFile)
except KeyboardInterrupt:
    print("\nUser interrupted")
    sys.exit(0)


