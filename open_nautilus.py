import os

# Vreau sa folosesc asta pentru a face o modalitate usoara de a-mi deschide foldere 
# Pun locatiile in locatii.conf in forma " [locatie]#[descriere]

class LocationLine:
    location = "."
    description = ""

    def __init__(self, location, description):
        self.location = location.strip()
        self.description = description.strip()

def extract_from_line(line):
    parts = line.split("#")
    if len(parts) != 2:
        return LocationLine("unknown location", "unknown description")
    else:
        return LocationLine(parts[0], parts[1])


location_options = []
with open("locatii.conf") as locatii_file:
    content = locatii_file.readlines()
    location_options = list(map(lambda location_line: extract_from_line(location_line), content))
    location_options = list(filter(lambda location_line: location_line.location != "unknown location" and location_line.description != "unknown description", location_options ))


count = 0
for loc in location_options:
    print("[%d] %s: \t%s" % (count, loc.description, loc.location))
    count +=1

location_number = int(input("Location: "))
os.system('nautilus ' + location_options[location_number].location )


