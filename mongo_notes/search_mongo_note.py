import db_connection
import sys


def containsSearchString(note, searchString):
    if note.name.lower().find(searchString) != -1:
        return True
    for content in note.contents:
        if content.lower().find(searchString) != -1:
            return True
    return False

def searchAllNotes(what):
    notes = db_connection.getAll()
    return list( filter( lambda note: containsSearchString(note, what), notes ) )

