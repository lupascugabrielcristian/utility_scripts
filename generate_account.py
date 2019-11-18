from bs4 import BeautifulSoup as bs
import requests
import random
import string

# r = requests.get("https://www.fakenamegenerator.com/gen-random-sp-pt.php");
country = random.choice(["Nederland", "Spain", "Germany", "France", "United Kingdom"])
parameters = {
        "pais": country,
        "sexo":"Male",
        "de":"18",
        "hasta":"60"
}
r = requests.post("http://www.datafakegenerator.com/generador.php", parameters)
content = r.content
soup = bs(content, "html.parser")
address = soup.findAll("p", class_="izquierda")
print(address[0].text)
print(address[3].text)
print("Address: %s, %s %s"% (address[5].text, address[7].text, address[8].text))
print("Zip code: %s" % address[6].text)

password = "".join(random.choice(string.ascii_lowercase + 
    string.ascii_uppercase + string.digits +
    "`~!@#$%^&*()_-+=[]{};:',<.>?")for n in range(12))
print(password)
