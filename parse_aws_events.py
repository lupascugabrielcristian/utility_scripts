import sys
import http.client
import time
import json

def get_my_ip():
    import http.client

    conn = http.client.HTTPSConnection("ip-geo-location.p.rapidapi.com")

    headers = {
        'x-rapidapi-key': "b14e5c2979msh863c9b4e1eed8eap141f6ajsn8625d31cc8be",
        'x-rapidapi-host': "ip-geo-location.p.rapidapi.com"
    }

    conn.request("GET", "/ip/check?format=json&language=en", headers=headers)

    res = conn.getresponse()
    data = res.read()
    data = data.decode("utf-8")
    data = json.loads(data)
    return data['ip']

# Making a call to RapidAPI service to lookup ip address
# Address for API: https://rapidapi.com/natkapral/api/ip-geo-location/playground/apiendpoint_0e95eebe-5290-481c-93d8-c417de659b25
def ip_lookup(ip, count):
    conn = http.client.HTTPSConnection("ip-geo-location.p.rapidapi.com")

    headers = {
        'x-rapidapi-key': "b14e5c2979msh863c9b4e1eed8eap141f6ajsn8625d31cc8be",
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

# I'm making a map with each IP as the key
# At this point the value of each key is the number of times an event was received from that IP
ips = {}
for line in sys.stdin:
    if '"IP":' in line:
        line = line.replace('"IP": "', '')
        line = line.replace('",', '')
        line = line.replace('\n', '')
        line = line.strip()

        if line in ips:
            ips[line] += 1
        else:
            ips[line] = 1

for k in ips:
    ip_lookup(k, int(ips[k]))
    time.sleep(1.1)

print('Own IP %s' % get_my_ip())

