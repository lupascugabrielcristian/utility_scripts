# Il pornesc din functii_scurtaturi.sh cu alias-ul codesearch
# Genereaza un fisier cu toate locatiile gasite
# Ex: codesearch retrofit java
# Trebuie rulat in locatia de unde va incepe cautarea. Cautarea se face recursiv

import os
import sys
import pdb
from inspect import getsourcefile
from itertools import groupby
from reportlab.pdfgen import canvas, textobject
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.pdfbase import pdfmetrics
from reportlab.lib import colors
from reportlab.lib import utils
from reportlab.lib.pagesizes import A4
from reportlab.platypus import Image, SimpleDocTemplate

# Primul argument sa fie locatia 
start_dir = sys.argv[1]

# Al doilea argument sa fie stringul cautat
s_text = sys.argv[2]

# Pasez al 2 lea argument extensia fisierelor care vreau sa le iau in considerare
extension = "." + sys.argv[3]

# Lista de obiect LinesFound care le voi face pdf
locations_collected = []

# Lista fisierelor in care s-a gasit stringul cautat
files_collected = []

# Culoarea cu care scrie numele fisierului 
file_name_color = "#2400FF"

# Culoarea default a textului
text_color = "#1A2E29"

# Line numer color
line_number_color = "#A1A1A1"

# Color for line number with the search result
line_number_color_result = "#FF7A7C"

# Color for the line the text is found
found_text_color = "#610001"

# How many lines to surround the found result
lines_up_down = 3

# Font size
font_size = 8

# Distace line number to text
number_to_text_d = 25

# Distance between lines
between_lines_d = 11

class LocationFound():
    def __init__(self):
        self.lines = []
        self.path = ""
        self.file_name = ""
        self.line_number = 0

    def __str__(self):
        return "File name: " + self.file_name


def is_file_good(path):
    """
    Filtreaza ce fisiere ma intereseaza
    """
    is_good = False

    if extension in path:
        is_good = True

    return is_good

def is_line_good(line):
    """
    Filtreaza o linie. De exemplu nu ma intereseaza cea care contine import...
    """
    is_good = True
    
    if "import" in line or \
        "public class" in line or \
        "public static" in line or \
        "private final" in line or \
        "private static" in line:
        is_good = False


    return is_good


def traverse(root, locations_collected):
    """
    Cauta recursiv toate fisierele
    """
    if "node_modules" in root:
        return

    if "__pycache__" in root:
        return

    if "build" in root:
        return

    if ".git" in root:
        return

    items = os.listdir(root)
    for item in items:
        path = os.path.join(root, item)
        if os.path.isdir(path):
            traverse(path, locations_collected)
        else:
            if not is_file_good(path):
                continue
        
            locations_file = search_text( s_text, path, item )

            if len(locations_file) > 0:
                if path not in files_collected:
                    files_collected.append(path)
                locations_collected += locations_file


def search_text( text, path, file_name ):
    """
    Cauta stringul dorit intr-un fisier. Daca il gaseste, returneaza 5 randuri in jurul liniei gasite
    Return:
        LocationFound[]
    """
    locations = []

    f = open(path, 'r', errors='ignore')
    line_number = 0
    content = f.readlines()

    for line in content:
        line_number += 1
        if text in line and is_line_good(line):
            location = LocationFound()
            location.path = path
            location.file_name = file_name
            location.line_number = line_number
            location.lines = ( content[ line_number - lines_up_down - 1: line_number + lines_up_down + 5 ] )
            locations.append(location)


    f.close()
    return locations


def check_page_end(pdf, current_line):
    if current_line < 200:
        pdf.showPage()
        current_line_y = 800
        return True
    else:
        return False


def generate_pdf_file( locations_dict ):
    """
    Primeste un dictionar cu cheile numele fisierelor
    """
    if len(locations_dict.keys()) == 0:
        return

    # creating a pdf object
    pdf = canvas.Canvas("/tmp/code-search.pdf", pagesize=A4)
    
    # setting the title of the document
    pdf.setTitle("code-search")

    # Font
    #pdf.setFont("Helvetica", font_size)

    current_line_y = 800
    for key in locations_dict:
        # Numele fisierului
        text_object = pdf.beginText()
        text_object.setFont("Helvetica", font_size)
        text_object.setTextOrigin( 20, current_line_y )
        text_object.textLine( key )
        current_line_y -= 25

        pdf.setFillColor(file_name_color)
        pdf.drawText( text_object )
        pdf.setFillColor(text_color)

        for location in list(locations_dict[key]):

            pdf.setFont("Helvetica", font_size)

            # Fiecare linie gasita
            for line in location.lines:
                text_object = pdf.beginText()
                text_object.setTextOrigin( 20, current_line_y )

                curent_line_number = location.line_number - lines_up_down + location.lines.index(line)

                if curent_line_number == location.line_number:
                    text_object.setFillColor(line_number_color_result )
                else:
                    text_object.setFillColor(line_number_color)
                text_object.textOut("[{0:04d}]".format(curent_line_number) )
                text_object.setFillColor(text_color)
                text_object.moveCursor(number_to_text_d, 0)

                # Pentru linia la care este gasit rezultatul, colorez cu background diferit
                if curent_line_number == location.line_number:
                    text_object.setFillColor(found_text_color)
                text_object.textOut(line.replace("\n", ""))
                text_object.setFillColor(text_color)

                current_line_y -= between_lines_d
                pdf.drawText( text_object )

            # Trec pe urmatoarea pagina daca este cazul
            if check_page_end(pdf, current_line_y):
                current_line_y = 800
            else:
                # Las un spatiu intre fiecare locatie gasita dintr-un fisier
                current_line_y -= 20



        # Trec pe urmatoarea pagina daca este cazul
        if check_page_end(pdf, current_line_y):
            current_line_y = 800
        else:
            current_line_y -= 35

    print("Generated PDF file /tmp/code-search.pdf")
    pdf.save()

def generate_md_file( locations_dict ):
    """
    Primeste un dictionar cu cheile numele fisierelor
    """

    if len(locations_dict.keys()) == 0:
        return

    # Create the file
    md_file = open("/tmp/code-search.md", "w")

    for key in locations_dict:
        # Numele fisierului
        md_file.write( "# " + key + " #\n")
        md_file.write("### " + locations_dict[key][0].path + " ###\n\n")

        for location in list(locations_dict[key]):

            # Fiecare linie gasita
            for line in location.lines:
                curent_line_number = location.line_number - lines_up_down + location.lines.index(line)

                if curent_line_number == location.line_number:
                    curent_line_number = "-{0:04d}-".format(curent_line_number)
                else:
                    curent_line_number = "[{0:04d}]".format(curent_line_number)
                output_line_text = curent_line_number + line
                md_file.write(output_line_text)

            # Las un spatiu dupa fiecare locatie
            md_file.write("\n\n")

        # Las un spatiu mai mare dupa fiecare fisier
        md_file.write("\n")

    md_file.close()
    print("Generated MD file /tmp/code-search.md")

print("Searching for \033[38;2;255;153;255m%s\033[0m in\033[38;2;153;204;255m %s \033[0m" % (s_text, start_dir ) )
traverse(start_dir, locations_collected)
if len(locations_collected) > 0:
    print(f'\033[38;2;153;255;51m%d locatii gasite \033[0m' % len(locations_collected) )
else:
    print("%d locatii gasite" % len(locations_collected) )
list(map(lambda f: print(" \u27A5 " + f), files_collected))

# Grupez dupa numele fisierului
dict_by_file_name = {} 
for loc in locations_collected:
    if loc.file_name in dict_by_file_name:
        dict_by_file_name[loc.file_name].append(loc)
    else:
        dict_by_file_name[loc.file_name] = [loc]


generate_pdf_file( dict_by_file_name )
generate_md_file( dict_by_file_name)
