#!/usr/bin/python3.10

import os

# Fisierul care va contine toate regulile cumulate din toate fisierele *.wiki din ~/prolog-wiki/
temp_prolog_file = "/tmp/prolog-wiki.pl"
prolog_wiki_directory = "/home/alex/prolog-vimwiki/"

merge_file = open(temp_prolog_file, "w")

for root, dirs, files in os.walk(prolog_wiki_directory):
    for wiki_file in files: 
        with open(root + wiki_file, 'r') as f:
            for l in f.readlines():
                merge_file.write(l)


merge_file.close()
