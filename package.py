#!/usr/bin/python3.7
import configparser
import subprocess
import glob
from datetime import datetime


configFilePath = r'./configs.ini'
config = configparser.ConfigParser()   
config.read(configFilePath)
include_paths = config['PATHS']['include']

exclude_paths = config['PATHS']['exclude']

file_name = datetime.now().strftime('%Y-%m-%d_%H-%M') + '.zip'
print("[+] Filename " + file_name)
initial_command="zip -FS -r -9 " + file_name 
command_with_includes = initial_command

included_paths_list = []
for path in include_paths.split('###'):
    if path.strip():
        included_paths_list.append(path.strip())
print("[Included list] = " + str(included_paths_list))

excluded_paths_list = []
for path in exclude_paths.split('###'):
    if path.strip():
        excluded_paths_list.append(path.strip())
print("[Excluded list] = " + str(excluded_paths_list))


subprocess.call(["zip", "-FS", "-r", "-9", file_name] + included_paths_list + ["-x"] + excluded_paths_list )
