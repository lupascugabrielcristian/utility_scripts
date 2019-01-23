from pymongo import MongoClient
from note import Note
import sys

client = MongoClient()
db = client.notes_database
collection = db.notes_collection

def addOneToDatabase():
    n = Note("mongo delete all")
    n.contents = [ "collection.delete_many({})"]
    nd = n.toMap()
    a = collection.insert_one(nd)

def readAllFromDatabase():
    cursor = collection.find({})
    for document in cursor:
        try:
            dn = Note(document['name'])
            dn.contents = document['contents']
            print(dn.toText())
        except KeyError:
            print ("KeyError")


if len(sys.argv) > 2:
    noteName = sys.argv[1]
    contents = []
    for argument in sys.argv[2:]:
        contents.append(argument)
    note = Note(noteName)
    note.contents = contents
    input("Adding new note with name " + noteName + "?")
    collection.insert_one(note.toMap())
else:
    print("Only displaying notes")

readAllFromDatabase()

# To add names and contents with spaces
# Filter by text
# Print in colors
