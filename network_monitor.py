import time

def transmissionrate(dev, direction, timestep):
    """Return the transmisson rate of a interface under linux
    dev: devicename
    direction: rx (received) or tx (sended)
    timestep: time to measure in seconds
    """
    path = "/sys/class/net/{}/statistics/{}_bytes".format(dev, direction)
    f = open(path, "r")
    bytes_before = int(f.read())
    f.close()
    time.sleep(timestep)
    f = open(path, "r")
    bytes_after = int(f.read())
    f.close()
    kbytes = (bytes_after-bytes_before) / 1024.0
    return kbytes/timestep

devname = "wlo1"
timestep = 2 # Seconds

while 1:
    print(str(transmissionrate(devname, "rx", timestep)) + " Kb")
