Cracking the hashes

Jon:1000:aad3b435b51404eeaad3b435b51404ee:ffb43f0de35be4d9917ac0cc8ad57f8d:::

john --wordlist wordlists/crackstation-human-only.txt --format=NT hashes.txt
============================================================
Warning: invalid UTF-8 seen reading wordlists/crackstation-human-only.txt
Error: UTF-16 BOM seen in input file.

john --wordlists wordlists/rockyou.txt --format=NT hashes.txt
=============================================================
Session completed fara sa reuseasca

john --format=nt hashes.txt
============================
A durat mai mult.
A scris ca a vazut 2 password hashes
A incercat cu Single, Wordlist default, incremental ...


Ce urmeaza este de aici:
https://medium.com/@petergombos/lm-ntlm-net-ntlmv2-oh-my-a9b235c58ed4

LM hashes
=========
Ex: 299BD128C1101FD6
-> pana la Vista
-> Comenzi:
john --format=lm hash.txt
hashcat -m 3000 -a 3 hash.txt

NTHash (A.K.A. NTLM)
====================
modern Windows systems
from SAM database
Ex: B4B9B02E6F09A9BD760F388B67351E2B
Algorithm: MD4(UTF-16-LE(password))
-> Comenzi:
john --format=nt hash.txt
hashcat -m 1000 -a 3 hash.txt
