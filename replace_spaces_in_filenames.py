import sys
import os

directory = os.path.abspath( sys.argv[1] )

for ( dirpath, dirname, filenames ) in os.walk(directory):
    for f in filenames:
        old_name = str(f)
        new_name = old_name.replace(' ', '_')
        os.rename( os.path.join(dirpath, old_name), os.path.join(dirpath, new_name) )
