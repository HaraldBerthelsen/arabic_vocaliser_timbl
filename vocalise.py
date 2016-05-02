import os



def vocalise(text):

    tmpname = "apa.timbl"
    tmpout = "%s.IB1.O.gr.k1.out" % tmpname

    command = "echo %s | perl bw2timbl.pl > %s; timbl -i timbl-data/test_shuf_traindata.ib -t %s &> /dev/null" % (text, tmpname, tmpname)
    
    #print(command)
    os.system(command)

    timbleout = open(tmpout)
    lines = timbleout.readlines()
    words = []
    letters = []
    for line in lines:
        line = line.strip()
        #print(line)
        fields = line.split(" ")
        focus = fields[3]
        diacritic = fields[11]
        nextchar = fields[4]
        letters.append(focus)

        if not diacritic == "X":
            letters.append(diacritic)
        if nextchar == "-":
            words.append("".join(letters))
            letters = []



    bw = " ".join(words)

    #get arabic 
    tmp_ar = "apa"
    ar_command = "echo %s > %s.bw; python buckwalter.py -toUTF -corpus %s.bw > %s.ar" % (bw, tmp_ar, tmp_ar, tmp_ar)
    os.system(ar_command)
    
    return bw


test = "ktb Albnt AlktAb"
wanted = "kataba Albint AlkitAb" #case endings?
#print(vocalise(test))

