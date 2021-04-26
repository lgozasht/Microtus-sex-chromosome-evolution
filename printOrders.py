mylist = []
with open('etc/XmOrder','r') as f:
    for line in f:
        mylist.append(line.strip())
print(';'.join(mylist))
