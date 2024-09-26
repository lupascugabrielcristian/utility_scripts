import io
import sys
import http.client
import time
import json
import re
from tabulate import tabulate
import logging
import pdb

rapid_api_key = sys.argv[1]

def get_my_ip():

    import http.client

    conn = http.client.HTTPSConnection("ip-geo-location.p.rapidapi.com")

    headers = {
        'x-rapidapi-key': rapid_api_key,
        'x-rapidapi-host': "ip-geo-location.p.rapidapi.com"
    }

    conn.request("GET", "/ip/check?format=json&language=en", headers=headers)

    try:
        res = conn.getresponse()
        data = res.read()
        data = data.decode("utf-8")
        data = json.loads(data)
        return data['ip']
    except KeyError as e:
        return '-'

# Making a call to RapidAPI service to lookup ip address
# Address for API: https://rapidapi.com/natkapral/api/ip-geo-location/playground/apiendpoint_0e95eebe-5290-481c-93d8-c417de659b25
def ip_lookup(ip, count):
    conn = http.client.HTTPSConnection("ip-geo-location.p.rapidapi.com")

    headers = {
        'x-rapidapi-key': rapid_api_key,
        'x-rapidapi-host': "ip-geo-location.p.rapidapi.com"
    }

    conn.request("GET", "/ip/{ip}?format=json&language=en".replace('{ip}', ip), headers=headers)

    res = conn.getresponse()
    data = res.read()
    data = data.decode("utf-8")
    data = json.loads(data)

    area = ''
    city = ''

    try:
        if data['area'] != None:
            area = data['area']['name']
        elif data['country'] != None:
            area = data['country']['name']

        if data['city'] != None:
            city = data['city']['name']


    except KeyError as e:
        area = 'failed'

    print("%s - count %d @ %s, %s" % (ip, count, area, city) )

input_data = sys.stdin.read()

# Making a map with each IP as the key
# At this point the value of each key is the number of times an event was received from that IP
ips = {}
for line in io.StringIO(input_data):
    match = re.search(r'"IP":\s"([\d,\.]+)"', line)
    if match:
        line = match.group(1)
        line = line.strip()

        if line in ips:
            ips[line] += 1
        else:
            ips[line] = 1

# for k in ips:
#     ip_lookup(k, int(ips[k]))
#     time.sleep(1.1)

# print('Own IP %s' % get_my_ip())

# Get json object from stdin
input_data = input_data.replace('}', '},')  # add ',' after each json
input_data = input_data[:-2]                # remote last ',' and '/n'
input_data = f'[%s]' % input_data           # surround with [,]
print(input_data)
input_data = json.loads(input_data)        # this is the json

from_data = list(map(lambda x: x['From'], input_data))
name_data = list(map(lambda x: x['Name'], input_data))
ip_data = list(map(lambda x: x['IP'], input_data))
time_data = list(map(lambda x: x['Time'], input_data))

# Creat the table
headers = ['From', 'Name', 'Time', 'IP']
print(tabulate({"From": from_data, "Name": name_data, "Time": time_data, "IP": ip_data}, headers=headers, tablefmt="grid"))
