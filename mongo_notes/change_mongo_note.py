import argparse
import db_connection

def printAllFromDatabase():
    list( map(lambda note: print(note.toText() ), notes) )
# -d to delete
# -cn --change-name 
# -ac --add-content
# -cc --change-content

def main():
    args = parser.parse_args()
    note = db_connection.getById(args.id)
    if note is None:
        print("Note with this id was not found")
        return
    if args.delete:
        input(f'Deleting note {note.name}')
        db_connection.deleteOne(note.id)
        return
    elif len(args.change_name) > 0:
        input(f'Changing the note name from {note.name} into {args.change_name}')
        return
    elif len(args.add_content) > 0:
        input(f'Adding the content {args.add_content} to the note {note.name}')
        return
    elif len(args.change_content) > 0:
        input (f'Changing the first content of note {note.name} into {args.change_content}')
        return


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--id', type=str, help='The id of the one to change')
    parser.add_argument('-d', '--delete', dest='delete', action='store_true', default=False, help='Add this argument to delete the note')
    parser.add_argument('-cn', '--change-name', type=str, default='')
    parser.add_argument('-ac', '--add-content', type=str, default='')
    parser.add_argument('-cc', '--change-content', type=str, default='')
    

main()

