from note import Note
import sys
import argparse
import db_connection

def printAllFromDatabase():
    notes = db_connection.getAll()
    list( map(lambda note: print(note.toText() ), notes) )

def printListForm():
    notes = db_connection.getAll()
    for n in notes:
        print(f'{n.name.lower()} {n.id}')

parser = argparse.ArgumentParser()
parser.add_argument('-l', '--list', dest='list', action='store_true', default=False, help='Show under list form')
args = parser.parse_args()

### From here
if args.list:
    printListForm()
    sys.exit(0)
if len(sys.argv) > 1:
    args = str(sys.argv[1:])
    noteDescription = (" ").join(sys.argv[1:])
    noteParts = str(noteDescription).split("???")
    note = Note(noteParts[0])
    contentParts = noteParts[1:]
    contents = []
    for argument in contentParts:
        contents.append(argument)
    note.contents = contents
    input("Adding new note with name " + note.name + "?")
    db_connection.getCollection().insert_one(note.toMap())
else:
    print("Only displaying notes")

printAllFromDatabase()

# To update an existing one
# Print in colors
