import random

id_length = 40
def generateId():
    a_code = ord('a')
    z_code = ord('z')
    _0_code = ord('1')
    _9_code = ord('9')

    allValidASCIICodes = []
    for i in range( ord('a'), ord('z') + 1 ):
        allValidASCIICodes.append(i)

    for i in range( ord('0'), ord('9') + 1 ):
        allValidASCIICodes.append(i)

    idString = ""
    for i in range(id_length):
        idString = idString + chr(random.choice(allValidASCIICodes))
    print(idString)


    

generateId()

