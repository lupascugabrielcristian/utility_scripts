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
parser.add_argument('-t', '--title', default='', required=False)
parser.add_argument('-c', '--content', nargs='+', default='', required=False)
parser.add_argument('-l', '--list', dest='list', action='store_true', default=False, help='Show under list form', required=False)
args = parser.parse_args()

### From here
if args.list:
    printListForm()
    sys.exit(0)


if len(args.title) > 1 and len(args.content) > 1:
    note = Note(args.title)
    contents = [ " ".join(args.content) ]
    note.contents = contents
    input("Adding new note with name " + note.name + "?")
    db_connection.getCollection().insert_one(note.toMap())
else:
    print("Only displaying notes")

printAllFromDatabase()

# To update an existing one
# Print in colors
