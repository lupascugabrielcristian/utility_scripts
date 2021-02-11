# 
# 
# Cauta in locatiile de mai jos dupa primul parametru dat la comanda 
# Functie de ce extensie are fisierul, il afiseaza cu un tag diferit, si il deschide diferit
# 
# 
# 

import os, sys
import subprocess
import pdb
from subprocess import call
from  search_mongo_note import searchAllNotes
from enum import Enum
import glob

# LOCATIONS
notesDirectory =            "/home/cristi/Documents/notes/"
researchNotesDirectory =    "/home/cristi/Documents/research/notes/"
booksDirectory =            "/home/cristi/Documents/Books/"
keepLocation =              "/home/cristi/keep.com"
allTheTimeScriptsDirectory = "/home/cristi/Documents/research/all_the_time_scrips/"
vimwikiDirectory =          "/home/cristi/vimwiki/"

class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    LIGHT_BLUE = '\033[96m'
    PINK = '\033[95m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

class FoundResultType(Enum):
    BOOK = 0
    NOTE = 1
    URL = 2
    COMMAND = 3
    SCRIPT = 4

class FoundResult:
    UNKNOWN_APPLICATION = "unknown_application"
    WITHOUT_EXTENSION = "without_extension"
    BASH = "sh"

    def __init__(self, what):
        self.application = FoundResult.UNKNOWN_APPLICATION
        self.extension = FoundResult.WITHOUT_EXTENSION
        self.what = what
        self.where = ""
        self.type = FoundResultType.BOOK


def chooseFile(foundResults):
    counter = 0
    if len(foundResults) == 0:
        return None
    for f in foundResults:
        ypeColor = colors.ENDC
        if f.type == FoundResultType.BOOK:
            typeColor = colors.WARNING
        elif f.type == FoundResultType.URL:
            typeColor = colors.LIGHT_BLUE
        elif f.type == FoundResultType.NOTE:
            typeColor = colors.OKGREEN
        elif f.type == FoundResultType.COMMAND:
            typeColor = colors.PINK
        elif f.type == FoundResultType.SCRIPT:
            typeColor = colors.OKBLUE 
        print(f'{counter:>3} {typeColor} {f.type.name:>7} {colors.ENDC} {f.what.strip()}')
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
    return list(filter(lambda f: f.lower().find(sys.argv[1].lower()) != -1 and '~' not in f, files))

# Functie de extensia fisierului, seteaza aplicatia cu care sa il deschida
def fileToFoundResult(fileFound, directory):
    result = FoundResult(fileFound)
    dotPosition = fileFound.rfind('.') + 1
    extension = fileFound[dotPosition:]
    result.extension = extension
    result.where = directory
    if extension == "pdf":
        result.application = "zathura"
        result.type = FoundResultType.BOOK
    elif extension == "txt" or extension == "md" or extension == "wiki":
        result.application = "nvim"
        result.type = FoundResultType.NOTE
    elif extension == "xmind":
        result.application = "XMind"
        result.type = FoundResultType.NOTE
    elif extension == "xmi":
        result.application = "umbrello5"
        result.type = FoundResultType.NOTE
    elif extension == "dia":
        result.application = "dia"
        result.type = FoundResultType.NOTE
    elif extension == "gv":
        result.application = "vimdot"
        result.type = FoundResultType.NOTE
    elif extension == "ctd" or extension == "ctb":
        result.application = "cherrytree"
        result.type = FoundResultType.NOTE
    return result


def openChosenOption(foundResult):
    if foundResult.application == FoundResult.UNKNOWN_APPLICATION:
        os.system("echo '" + foundResult.what.strip() + "' | xclip")
        print("Use xclip -o to paste")
    elif foundResult.type == FoundResultType.SCRIPT:
        call([foundResult.application, foundResult.where])
    elif foundResult.application == "w3m":
        call([foundResult.application, foundResult.what])
    else:
        print("Aplication: " + foundResult.application)
        print("Location: " + foundResult.where + foundResult.what)
        call([foundResult.application, foundResult.where + foundResult.what])

def searchOnline(searchTextParts):
    searchText = '+'.join(searchTextParts)
    searchText = searchText.replace('+--no-mongo', '')
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
        result.type = FoundResultType.URL
    else:
        result.application = FoundResult.UNKNOWN_APPLICATION
        result.type = FoundResultType.COMMAND
    return result

def searchMongoNotes(forWhat):
    mongoNotes = searchAllNotes(forWhat)
    mongoNotesContents = mergeNotesContents(mongoNotes);
    return list( map( lambda c: createResultFromMongoContent(c), mongoNotesContents ) )

def searchFiles():
    found_results = []
    files = os.listdir(notesDirectory)

    files = filterFilesAfterArgument(files)
    found_results += list( map( lambda f: fileToFoundResult(f, notesDirectory), files ) )

    files = os.listdir(researchNotesDirectory)
    files = filterFilesAfterArgument(files)
    found_results += list( map( lambda f: fileToFoundResult(f, researchNotesDirectory), files ) )

    files = os.listdir(booksDirectory)
    files = filterFilesAfterArgument(files)
    found_results += list( map( lambda f: fileToFoundResult(f, booksDirectory), files ) )

    files = os.listdir(booksDirectory)
    dirs = list( filter( lambda d: os.path.isdir( booksDirectory + d ) is True, files) )
    for d in dirs:
        files = os.listdir( booksDirectory + d)
        files = filterFilesAfterArgument(files)
        found_results += list( map( lambda f: fileToFoundResult(f, booksDirectory + d + "/"), files ) )


    return found_results

def keepToFoundResult(line, location):
    found_result = FoundResult(line)
    found_result.type = FoundResultType.NOTE
    found_result.where = location
    found_result.application = FoundResult.UNKNOWN_APPLICATION
    return found_result

def searchKeepFile():
    found_results = []
    if os.path.exists(keepLocation):
        with open(keepLocation, "r") as keep_file:
            lines = keep_file.readlines()
            lines = list(filter( lambda line: sys.argv[1] in line, lines ))
            found_results = list( map( lambda line: keepToFoundResult(line, keepLocation), lines))
    else:
        print("Keep file not found")
        
    return found_results


def allTimeScriptToFoundResult(filePath) -> FoundResult:
    what = filePath.split('/')[-1].split('.')[0] 
    found_result = FoundResult(what)
    found_result.type = FoundResultType.SCRIPT
    found_result.where = filePath
    found_result.application = "nvim"
    return found_result


def searchInsideScript(path) -> bool:
    if not os.path.exists(path):
        return False
    if sys.argv[1] in path.split(".")[-2]:
        return True

    with open(path, "r") as script_file:
        lines = script_file.readlines()
        return len( list(filter( lambda line: "function " + sys.argv[1] in line or \
                sys.argv[1] in line, lines ))) > 0
    

def searchAllTimeScripts():
    files = glob.glob(allTheTimeScriptsDirectory + "**/*.sh", recursive=True)
    files_with_results = list(filter(lambda f: searchInsideScript(f), files))
    return list(map(lambda found_file: allTimeScriptToFoundResult(found_file), files_with_results))


def searchVimWiki():
    results_to_add = []
    wikis = os.listdir( vimwikiDirectory )
    for wiki in wikis:
        if os.path.isdir( vimwikiDirectory + wiki + "/" ) is True:
            continue

        with open( vimwikiDirectory + wiki, "r") as wiki_file:
            lines = wiki_file.readlines()
            found_lines = list( filter( lambda l: sys.argv[1] in l, lines ))
            if len( found_lines ) > 0:
                results_to_add.append( fileToFoundResult( wiki, vimwikiDirectory ))
    return results_to_add


######## Starts here ########
if len(sys.argv) == 1:
    print("There are not enough arguments")
    sys.exit(1)

# to skip mongo add --no-mongo
allResults = searchFiles()

#if "".join(sys.argv[1:]).find('--no-mongo') == -1:
#    allResults += searchMongoNotes(sys.argv[1]) 

allResults += searchKeepFile()
allResults += searchAllTimeScripts()
allResults += searchVimWiki()

try:
    chosenFile = chooseFile(allResults)
    if chosenFile is None:
        searchOnline(sys.argv[1:])
    else:
        openChosenOption(chosenFile)
except KeyboardInterrupt:
    print("\nUser interrupted")
    sys.exit(0)


