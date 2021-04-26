import numpy as np

teDic = {}
XmDic = {}
XpDic = {}
with open('XmLengthsOrdered.txt','r') as f:
    for line in f:
        sp = line.split(' ')        
        XmDic[sp[2].strip()] = int(sp[5].strip())

with open('XpLengthsOrdered.txt','r') as f:
    for line in f:
        sp = line.split(' ')
        XpDic[sp[2].strip()] = int(sp[5].strip())
nucDic = {}
with open('AllTransposases.Combined.reversed','r') as f:
    for line in f:
        sp = line.split('\t')
        if sp[0] not in teDic:
            if sp[0] in XmDic:
                teDic[sp[0]] = [XmDic[sp[0]] - int(sp[1])]
                nucDic[XmDic[sp[0]] - int(sp[1])] = abs(int(sp[1]) - int(sp[2]))

            else:
                teDic[sp[0]] = [int(sp[1])]
                nucDic[int(sp[1])] = abs(int(sp[1]) - int(sp[2]))


        else:
            if sp[0] in XmDic:

                teDic[sp[0]].append(XmDic[sp[0]] - int(sp[1]))
                nucDic[XmDic[sp[0]] - int(sp[1])] = abs(int(sp[1]) - int(sp[2])) 
            else:
                teDic[sp[0]].append(int(sp[1]))
                nucDic[int(sp[1])] = abs(int(sp[1]) - int(sp[2]))
binDense = {}
       

for cont in teDic:
    print(teDic[cont])
    data = (teDic[cont])
    if cont in XmDic:
        try:
            binDense = {}
            bins = range(0, XmDic[cont],100000)
            for i in bins:
                binDense[i] = 0
                for k in data:
                    if k > i and k < i + 100000:
                        binDense[i] += nucDic[k]
                    

            
            with open('teHistData.txt','a') as f:
                for i in binDense:
                    if i+100000 > XmDic[cont]:
                        f.write('{0}\t{1}\t{2}\t{3}\n'.format(cont,str(i),str(XmDic[cont]),binDense[i]/(XmDic[cont]-i)))
                    else:
                        f.write('{0}\t{1}\t{2}\t{3}\n'.format(cont,str(i),str(i+100000),str(binDense[i]/100000)))

        except ValueError:
            print(cont)
    if cont in XpDic:
        try:
            binDense = {}

            bins = range(0, XpDic[cont],100000)
            for i in bins:
                binDense[i] = 0

                for k in data:
                    if k > i and k < i + 100000:
                        binDense[i] += nucDic[k]



            with open('teHistData.txt','a') as f:
                for i in binDense:
                    if i+100000 > XpDic[cont]:
                        f.write('{0}\t{1}\t{2}\t{3}\n'.format(cont,str(i),str(XpDic[cont]),binDense[i]/(XpDic[cont]-i)))
                    else:
                        f.write('{0}\t{1}\t{2}\t{3}\n'.format(cont,str(i),str(i+100000),str(binDense[i]/100000)))
            '''
            bins = np.arange(0, XpDic[cont],100000)
            #print(bins)
            digitized = np.digitize(data, bins)
            bin_means = [data[digitized == i].mean() for i in range(1, len(bins))]
            myMeans = [i/XpDic[cont] for i in bin_means]
            with open('teHistData.txt','a') as f:
                count = 0
                for i in myMeans:

                    if count+100000 > XpDic[cont]:
                        f.write('{0}\t{1}\t{2}\t{3}\n'.format(cont,str(count),str(XpDic[cont]),i))
                    else:
                       f.write('{0}\t{1}\t{2}\t{3}\n'.format(cont,str(count),str(count+100000),i))
                       count += 100000 
            '''
        except ValueError:
            print(cont)
