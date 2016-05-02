import socket, sys, re

s = socket.socket()
s.connect(("localhost",7000))
reply = s.recv(1024)
#print(reply)
#print("sending..")

lines = sys.stdin.readlines()

words = []
letters = []
for line in lines:
    s.send("c %s" % line)

    line = line.strip()
    #print(line)
    fields = line.split(" ")
    focus = fields[3]
    nextchar = fields[4]

    #print("receiving..")
    #print s.recv(1024)
    #print("closing..")
    
    sockfile = s.makefile('r')

    res = sockfile.readline()

    #print res

    m = re.match("CATEGORY {(.+)}", res)
    if m:
        diacritic = m.group(1)

        letters.append(focus)

        if not diacritic == "X":
            letters.append(diacritic)
        if nextchar == "-":
            words.append("".join(letters))
            letters = []

s.close()

bw = " ".join(words)
print bw 

