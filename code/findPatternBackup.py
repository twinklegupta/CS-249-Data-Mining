#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 11 17:10:56 2017

@author: twinklegupta
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 11 12:35:55 2017

@author: twinklegupta
"""

from collections import Counter

map1 = dict()
for key,value in map.items():
    if(len(value) == 1):
        stringValue = value[0].split(":")
        if(stringValue[0] == "t" or  stringValue[0] == "u"):
            print("anomaly of strength 4 : ")
            print(key[0], " to  ", key[1])
    else:
        map1[key] = value



occurences = dict()

for key,value in map1.items():
    string = ':'.join(value)
    split_string = string.split(":")
#    print(split_string)
    occurence = np.zeros(27, dtype=np.int)
    sp = split_string[1::2]
    indices = [int(i) for i in sp]
    indices = np.add(indices,-1)
    occurence[indices] = np.int(1)
    occurences[key] = ''.join(str(x) for x in occurence)
    

not_found_pattern = dict()
found = FALSE
times=2
for key,occurence in occurences.items():
    found = FALSE
    a = occurence
    for n in range(1,len(a)/times+1):
        substrings=[a[i:i+n] for i in range(len(a)-n+1)]
        freqs=Counter(substrings)
        if freqs.most_common(1)[0][1]<times:
            n-=1
            break
        else:
            found = TRUE
            seq=freqs.most_common(1)[0][0]
    if(found == FALSE):
        not_found_pattern[key] = occurence
print ("sequence '%s' of length %s occurs %s or more times"%(seq,n,times))
    
        
def processPattern( pattern ):
    
            