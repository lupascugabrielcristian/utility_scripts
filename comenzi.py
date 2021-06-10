# Cauta in [comenzi.list] si executa cu o confirmare linia care a gasit-o
# Daca gasesc mai multe linii sa le afisez cu un numar in fata si sa aleg
# Ideea ar fi sa pun in comenzi.list toate cele care vreau sa le tin minte

import sys
import os

search_term = sys.argv[1]

with open('comenzi.list', "r") as comenzi_file:
    lines = comenzi_file.readlines()
    lines_containing_term = list( filter( lambda l: search_term in l, lines) )
    if len( lines_containing_term ) == 1:
        found_line = lines_containing_term[0]
        if "#" in found_line:
            found_line = found_line[:found_line.index("#")].strip()
        else:
            found_line = found_line.strip()
        print( found_line )
        input("Run?")
        os.system(lines_containing_term[0].strip())
    else:
        for count, enum_line in enumerate(lines_containing_term):
            print("%d. %s" % (count, enum_line.strip()) )
        answer_number = int( input("Care linie?") )
        # execute line number answer_number
        found_line = lines_containing_term[answer_number].strip()
        if "#" in found_line:
            found_line = found_line[:found_line.index("#")].strip()
        print( found_line )
        input("Run?")
        os.system(lines_containing_term[answer_number].strip())
