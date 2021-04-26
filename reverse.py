myDic = {}
with open('XmLengthsOrdered.txt','r') as f:
    for line in f:
        sp = line.split(' ')
        myDic[sp[2]] = int(sp[5])        
print(myDic)
with open('CircosData.XpXm.ABfixed','r') as f:
    for line in f:
        sp = line.split('\t')
        with open('links_reversed_XpXm2.txt','a') as f2:
            #print(str(int(myDic[sp[3].strip()])-int(sp[4])))
            #print(myDic[sp[3].strip()],sp[4])
            #print(sp[4])
            #print(str(int(myDic[sp[3].strip()])-int(sp[5])))

            f2.write('{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\n'.format(sp[0],sp[1],sp[2],sp[3],str(int(myDic[sp[3].strip()])-int(sp[4])),str(int(myDic[sp[3].strip()])-int(sp[5])),sp[6]))
        #    f2.write('{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\n'.format(sp[0],str(int(myDic[sp[0].strip()])-int(sp[1])),str(int(myDic[sp[0].strip()])-int(sp[2])),sp[3],str(int(myDic[sp[3].strip()])-int(sp[4])),str(int(myDic[sp[3].strip()])-int(sp[5])),sp[6]))
        '''
        with open('Genes2.txt','a') as f2:

            if 'Xm' in line:
                f2.write('{0}\t{1}\t{2}\t{3}\n'.format(sp[2],str(int(myDic[sp[2].strip()])-int(sp[3])),str(int(myDic[sp[2].strip()])-int(sp[4].strip())),sp[0]))
            else:
                f2.write('{0}\t{1}\t{2}\t{3}\n'.format(sp[2],sp[3],sp[4].strip(),sp[0]))
        '''
