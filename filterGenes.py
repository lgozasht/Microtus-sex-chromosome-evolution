with open('etc/GenesToMark2','r') as f:
    for line in f:
        with open('etc/Genes2.txt','r') as f2:
            for line2 in f2:
                if line2.split('\t')[-1] in line:
                    with open('etc/GenesToMark2_edited','a') as f3:
                        f3.write(line)

