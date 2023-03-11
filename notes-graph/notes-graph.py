import os
import sys
import re
import configparser

VIMWIKI_FOLDER = "/home/alex/vimwiki/"
DEFAULT_OUTPUT_FILE="input.dot"

# if len(sys.argv) == 1:
#     print("No search input")
#     exit(0)
search_text = "nginx"

# Read configurations
config = configparser.ConfigParser()
config_found = False

cwd = os.getcwd() 
configuration_file_path = cwd + '/configs.ini' 
if not os.path.exists(configuration_file_path):
    print("No config file found")
else:
    config.read(configuration_file_path)
    config_found = True

def get_config_property(parent,prop_name, default_val):
    if config_found:
        return config[parent][prop_name]
    else:
        return default_val

# Pregatesc fisierul graficului
output_file = cwd + "/" + DEFAULT_OUTPUT_FILE
# Daca am config.ini iau de acolo numele fisierului
if config_found:
    output_file = cwd + "/" + config['Graph']['file_name']

if os.path.exists(output_file):
    # Sterg fisierul vechi daca exista
    os.remove(output_file)

# Creez unul nou cu inceputul graficului
f = open(output_file, 'w')
f.write("digraph {\n")
f.write("\trankdir=LR;\n")
f.close() 



def get_links(line):
    pattern = re.compile("\[\[([\w:.|\/]*)\]\]")

    if pattern.search(line) is None:
        return []

    link_segments_incomplete = line.split("[[")
    link_segments_incomplete = list(filter(lambda s: len(s) > 0, link_segments_incomplete ))
    link_segments_complete = list(map(lambda s: "[[" + s, link_segments_incomplete))

    search_results = list(map(lambda s: pattern.search(s), link_segments_complete))
    search_results = list(filter(lambda s: s is not None and len(s.groups()) > 0, search_results))
    search_results = list(map(lambda s: s.group(1), search_results))

    return search_results

def search_for_text(file, text):
    """
    Cauta textul in fisierul dat

    Returns:
        True daca gaseste textul oriunde in fisier
        False otherwise
    """
    if not os.path.exists(file):
        return Fale
    
    with open(file, 'r') as f:
        return text in f.read()

def search_for_links(file):
    """
    Cauta intr-un fisier linkurile

    Return:
        O lista cu denumirile linkurilor
    """
    if not os.path.exists(file):
        return []

    links = []
    with open(file, 'r') as f:
        for l in f.readlines():
            links += get_links(l)

    return links


# Fisierele care contin textul cautat
search_results_files = []

# Hashmap care tine o legatura intre vimwiki file si linkurile din el
links_dict = {}

for f in os.listdir(path=VIMWIKI_FOLDER):
    if os.path.isdir(VIMWIKI_FOLDER + f):
        continue

    if f == "index.wiki" and config_found and config['Search']['include_index'] == "False":
        continue

    links = search_for_links( VIMWIKI_FOLDER + f)
    if len(links) > 0:
        links_dict[f] = links


    if search_for_text( VIMWIKI_FOLDER + f, search_text) is True:
        search_results_files.append( VIMWIKI_FOLDER + f)


print("Files found that contain the search text: ")
for ff in search_results_files:
    print(ff)
    
def surround_with_quotes(text):
    """
    Doar pune " in jurul textului pentru a putea fi citit corect de programul dot
    """
    return '"' + text + '"'

def node_to_url_node(node):
    if "|" in node:
        parts = node.split("|")
        return parts[1].strip()
    else:
        "URL"


def file_to_node(text):
    """
    Sterge .wiki si path-ul catre fisier lasand doar denumirea care apare in linkul in fisierul vimwiki
    Ex /home/cristi/vimwiki/node.wiki -> node
    """
    text = text.replace(".wiki", "").replace(VIMWIKI_FOLDER, "")
    # Pun pe 2 randuri daca e prea lunga denumirea fisierului
    max_file_name = int(get_config_property("Graph", 'max_file_name', 10))
    if len(text) > max_file_name:
        text = text[:max_file_name] + '\n' + text[max_file_name:]

    return surround_with_quotes(text)

# La Nivelul 1 sunt fisierele care contin textul cautat
search_results_nodes = list(map(lambda ft: file_to_node(ft), search_results_files))

of = open(output_file, 'a')
for node in search_results_nodes:
    of.write("\t%s -> %s\n" % ( search_text, node ))

skip_keep_in_mind_notes = True
if config_found and config['Search']['include_keepinmindnotes'] == True:
    skip_keep_in_mind_notes = False

# La Nivelul 2 sunt link-urile vimwiki din fisiere gasite la Nivelul 1
for srf in search_results_files:

    # Sar peste KeepInMindNotes daca nu este setat in config.ini altfel
    if "KeepInMindNotes" in srf and skip_keep_in_mind_notes:
        continue

    srf = srf.replace(VIMWIKI_FOLDER, "")
    if srf in links_dict:
        node = srf.replace(".wiki", "")
        node = surround_with_quotes(node)


        for link in links_dict[srf]:

            if "http://" in link or "https://" in link:
                link = node_to_url_node(link)

            of.write( "\t%s -> %s\n" %(node, surround_with_quotes(link)) )


# Close the dot file
of.write("}")
of.close() 

