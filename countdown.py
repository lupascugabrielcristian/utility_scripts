import time
from datetime import datetime


tasksFileName = 'tasks'
separator = '#'


class CountdownTask:
    name = ""
    endHour = 0
    endMinute = 0

def extractTaskFromLine(line):
    parts = line.split(separator)
    task = CountdownTask()
    if len(parts) != 3:
        return task
    task.name = parts[0]
    task.endHour = int(parts[1])
    task.endMinute = int(parts[2])
    return task

def printTask(task):
    taskEndInMinutes = task.endHour * 60 + task.endMinute
    nowInMinutes = datetime.now().hour * 60 + datetime.now().minute
    remaining = taskEndInMinutes - nowInMinutes
    if remaining < 0:
        print("[%s] END" % task.name)
    else:
        print("[%s] Ends in %d" % (task.name, remaining))



def readFile():
    while(1):
        with open(tasksFileName) as tasksFile:
            content = tasksFile.readlines()

        tasks = list(map(lambda contentLine: extractTaskFromLine(contentLine), content))
        tasks = list(filter(lambda task: task.name != "", tasks))
        print("\n\nThere are " + str(len(tasks)) + " tasks")
        for t in tasks:
            printTask(t)
        time.sleep(60)



readFile()
