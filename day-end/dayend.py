import subprocess
import os

# TODO
# Sa verific daca am facut sync

directories = []

home_dir = os.path.expanduser('~')


class Result:

    def __init__(self):
        self.is_success = True
        self.reasons = []


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
    TEST = '\038[2;0;128;0m'


result = Result()

# Daca nu gasesc fisierul day-end.paths atunci folosesc un fiser de configurare 
# la care trebuie sa adaug home folder inaintea fiecarei linii
if not os.path.exists(home_dir + "/.config/day-end/day-end.paths"):
    print(f"{colors.WARNING}User config file {colors.HEADER}~/.config/day-end/day-end.paths{colors.WARNING} not found.{colors.ENDC}\nFall-back to day-end.default paths file")

    # Get location of script file
    script_location = os.path.dirname(__file__)

    # Open default cofig file based on location of script
    with open(script_location + "/day-end.default") as f:
        for l in f.readlines():
            if os.path.exists(home_dir + l.strip()):
                directories.append(home_dir + l.strip())
else:
    # Foloses fisierul de configurare in ~/.config/day-end/day-end.paths
    with open(home_dir + "/.config/day-end/day-end.paths") as f:
        for l in f.readlines():
            directories.append(l.strip())

clean = []
not_commited = []
failed = []

# Step 1
# In fiecare director din ~/.config/day-end/day-end.paths rulez git status pentru a vedea daca am comis toate modificarile
for d in directories:
    if os.path.exists(d):
        os.chdir(d)
    else:
        print("Path " + d + " doesn't exists")
        continue

    try:
        output = subprocess.check_output("git status 2>/dev/null", shell=True)
    except:
        failed.append(d)
        continue
    output = bytes.decode(output)
    #print(bytes.decode(output))

    path_parts = d.split("/")
    if "nothing to commit, working tree clean" in output:
        clean.append(path_parts[len(path_parts) - 1])
    else:
        not_commited.append(path_parts[len(path_parts) - 1])

if len(failed) > 0:
    print("\nFAILED")
    for f in failed:
        print(f)

print("\nCLEAN")
for c in clean:
    print(c)

print("\nCHANGES NOT COMMITED")
for n in not_commited:
    print(n)

print()
if len(not_commited) != 0:
    result.is_success = False
    result.reasons.append("GIT STATUS FAILED")

# Step 2
# Ma asigur ca am inchis kpcli. Verific daca am safe.kpcli.lock
kpcli_lock = ["/safe.kli.lock", "/safe.kp"]
for k in kpcli_lock:
    if os.path.exists( home_dir + k ):
        result.is_success = False
        result.reasons.append("kpcli still open")
        break


# Final
if result.is_success == False:
    print("PROCESS FAILED with reasons")
    for r in result.reasons:
        print("  -> " + r)
else:
    print(f"{colors.OKGREEN}PROCESS SUCCESSFUL{colors.ENDC}")
