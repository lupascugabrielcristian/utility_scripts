import subprocess
import os
import requests
from base64 import b64encode
from configparser import ConfigParser
import time

directories = []

# De ex /home/cristi
home_dir = os.path.expanduser('~')

# Obtain the user configurations if exists
user_config = None
if os.path.exists(home_dir + '/.config/day-end/config.ini'):
    user_config = ConfigParser()
    user_config.read(home_dir + '/.config/day-end/config.ini')
    print("User config file found")


class Result:

    def __init__(self):
        self.is_success = True
        self.reasons = []


class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    LIGHT_ORANGE = '\033[38;2;255;204;153m'
    MEDIUM_ORANGE = '\033[38;2;255;153;51m'
    FAIL = '\033[91m'
    LIGHT_BLUE = '\033[96m'
    PINK = '\033[95m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    TEST = '\033[38;2;0;128;0m'


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
kpcli_lock = ["/safe.kli.lock", "/safe.kp.lock"]
for k in kpcli_lock:
    if os.path.exists( home_dir + k ):
        result.is_success = False
        result.reasons.append("kpcli still open")
        break

# Step 3 
# Ma asigur ca cronometrul din Toggle nu este pornit
credentials_string = user_config['toggle']['user'] + ":" + user_config['toggle']['pass']
data = requests.get('https://api.track.toggl.com/api/v9/me/time_entries', headers={'content-type': 'application/json', 'Authorization' : 'Basic %s' %  b64encode( bytes(credentials_string, 'utf-8')).decode("ascii")})
try:
    last_entry = data.json()[0]
    if last_entry['stop'] == None:
        result.is_success = False
        result.reasons.append("Toggle still running")
except:
    print(f"{colors.MEDIUM_ORANGE}Failed to make Toggle call{colors.ENDC}")

# Step 4
# Verific daca am facut sync din projects/utility_scripts
if os.path.exists(home_dir + "/projects/utility_scripts/last_push.log"):
    with open(home_dir + "/projects/utility_scripts/last_push.log", 'r') as f:
        lines = f.readlines()
        try:
            last_push_time = int(lines[1].strip())
            current_time = round(time.time())
            # O zi are 86400 secunde. Vreau ca ultimul push sa fie facut la mai putin de o zi
            if current_time - last_push_time > 86400:
                result.is_success = False
                days_passed = (current_time - last_push_time) / 86400
                result.reasons.append("Last sync done %.1f days ago" % days_passed)
        except Exception as e:
            result.is_success = False
            result.reasons.append("Failed to get last sync time")
else:
    print(f"{colors.MEDIUM_ORANGE}Failed to find last_push.log file{colors.ENDC}")

# Final
if result.is_success == False:
    print("PROCESS FAILED with reasons")
    for r in result.reasons:
        print("  -> " + r)
else:
    print(f"{colors.OKGREEN}ALL CHECKS SUCCESSFUL{colors.ENDC}")
