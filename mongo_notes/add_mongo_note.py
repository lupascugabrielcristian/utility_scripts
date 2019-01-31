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
parser.add_argument('-l', '--list', dest='list', action='store_true', default=False, help='Show under list form', required=False)
parser.add_argument('-a', '--all', dest='all', action='store_true', default=False, help='Show all with details', required=False)
args = parser.parse_args()

### From here
if args.list:
    printListForm()
    sys.exit(0)

if args.all:
    printAllFromDatabase()
    sys.exit(0)

title = input("Title: ")
content = input("Content: ")

if len(title) > 1 and len(content) > 1:
    note = Note(title)
    note.contents.append(content.strip())
    input("Adding new note with name " + note.name + "?")
    db_connection.getCollection().insert_one(note.toMap())

# To update an existing one
# Print in colors
