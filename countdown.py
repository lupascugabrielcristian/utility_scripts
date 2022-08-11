import time
import os
import sys
from datetime import datetime
from subprocess import call
import subprocess

separator = '#'

class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    LIGHT_BLUE = '\033[96m'
    PINK = '\033[95m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

class CountdownTask:
    name = ""
    endHour = 0
    endMinute = 0
    command = ""

def extractTaskFromLine(line):
    parts = line.split(separator)
    task = CountdownTask()
    if len(parts) < 3:
        return task
    try:
        task.name = parts[0]
        task.endHour = int(parts[1])
        task.endMinute = int(parts[2])

        if len(parts) >= 4:
            task.command = parts[3]

        return task
    except ValueError:
        return task

def printTask(task):
    taskEndInMinutes = task.endHour * 60 + task.endMinute
    nowInMinutes = datetime.now().hour * 60 + datetime.now().minute
    remaining = taskEndInMinutes - nowInMinutes
    if remaining < 0:
        print(f'{colors.FAIL} [{task.name}] END {colors.ENDC}' )
    elif remaining == 0:
        print(f'{colors.WARNING} [{task.name}] END {colors.ENDC}' )
    else:
        print(f'{colors.OKGREEN} [{task.name}] {remaining} {colors.ENDC}')


def readFile(tasksFile):
    while(1):
        with open(tasksFile) as t:
            content = t.readlines()

        tasks = list(map(lambda contentLine: extractTaskFromLine(contentLine), content))
        tasks = list(filter(lambda task: task.name != "", tasks))
        os.system("clear")
        print(f"{colors.LIGHT_BLUE} {len(tasks)} tasks {colors.ENDC}")
        for t in tasks:
            printTask(t)
        print(f"{colors.LIGHT_BLUE} ____ {colors.ENDC}", end="", flush=True)
        time.sleep(15)
        print(f"\r{colors.LIGHT_BLUE} #___ {colors.ENDC}", end="", flush=True)
        time.sleep(15)
        print(f"\r{colors.LIGHT_BLUE} ##__ {colors.ENDC}", end="", flush=True)
        time.sleep(15)
        print(f"\r{colors.LIGHT_BLUE} ###_ {colors.ENDC}", end="", flush=True)
        time.sleep(15)
        print(f"\r{colors.LIGHT_BLUE} #### {colors.ENDC}", end="", flush=True)

if len(sys.argv) < 2:
    print("Need the path to tasks file")
    exit(1)

tasksFile = sys.argv[1]
readFile(tasksFile)
