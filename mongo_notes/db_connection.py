from pymongo import MongoClient
from pymongo.errors import ConnectionFailure
from bson.objectid import ObjectId

from note import Note

host = 'localhost'
port = 27017
def checkConnection(client):
    try:
        client.admin.command('ismaster')
    except ConnectionFailure:
        print("No connection. Exiting!")
        sys.exit(1)

def getCollection():
    client = MongoClient(host, port)
    checkConnection(client)
    db = client.notes_database
    collection = db.notes_collection
    return collection

def deleteOne(idString):
    deleteResult = getCollection().delete_one({"_id": ObjectId(idString)})
    if deleteResult.deleted_count != 1:
        print(f'Operation not successful. Deleted {deleteResult.deleted_count}')
    return cursor

def getAll():
    cursor = getCollection().find({})
    notes = []
    for document in cursor:
        try:
            note = Note(document['name'])
            note.contents = document['contents']
            note.id = document['_id']
            notes.append(note)
        except KeyError:
            print ("Invalid note entry")
    return notes

def getById(idString):
    found = list( filter( lambda note: str(note.id).find(idString) != -1, getAll()) )
    if len(found) == 0:
        return None
    return found[0]

