#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Mar 12 15:04:10 2017

@author: twinklegupta
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Mar 11 12:35:55 2017

@author: twinklegupta
"""

from collections import Counter
import re
import pandas as pd


deault_min_score = -1000

def generatePattern(value):
    string = ':'.join(value)
    split_string = string.split(":")
#    print(split_string)
    occurence = np.chararray(27,unicode=True)
    occurence[:] = '0'
    sp = split_string[1::2]
    indices = [int(i) for i in sp]
    indices = np.add(indices,-1)
    occurence[indices] = split_string[0::2]
    return (''.join(occurence))

#committee suddenly stopped giving
def processPattern(pattern):
#    print("pattern", pattern)
    pattern_stripped = pattern.strip('0')
#    print(pattern_stripped)
    length_stripped = len(pattern_stripped)
    num_zeros = pattern_stripped.count('0')
#   
    length_trailing_zeros = len(pattern) - len(pattern.rstrip('0'))
    loyalty_score = (float)(length_stripped-num_zeros)/(length_stripped+length_trailing_zeros)
    if loyalty_score == 1 and length_trailing_zeros == 0:
        return deault_min_score
#    print("Loyalty score ----- ", loyalty_score)
    max_consec_zeros  =0
    patterns = re.findall(r'0+', pattern_stripped)
    if len(patterns) != 0:
         max_consec_zeros = max(len(s) for s in patterns)
    leverage_score = 0
    add_score = (float)(length_trailing_zeros)/length_stripped
    if loyalty_score != 0:
        leverage_score = (float)(max_consec_zeros + add_score)/loyalty_score
    return (-leverage_score)
#    return ((length_trailing_zeros - leverage_score)/(length_trailing_zeros+1.0))


def normalise(myDict):
    df = pd.DataFrame.from_dict(myDict, orient='index').reset_index()
    df_norm = (df[0] - df.min()[1])/(df.max()[1] - df.min()[1])
    df[0] = df_norm
    return df
              
#committee suddenly gives high amount
def processPatternWeight(pattern):
    print("processPatternWeight:::: ",pattern)
    val = {'p':1,'q':2,'r':3,'s':4,'t':5,'u':6,'v':7}
    count = Counter(pattern)
    print("count : ", count)
    max_count = 0
    max_val = ''
    for key,value in count.items():
        if key != '0' and key != '-' and key != '1' and key != '8' and max_count <= value:
            max_count = value
            max_val = key
    print("max_count : max_key : ", max_count," ", max_val)
    anomaly = 0
    freq_count = 0
    for key,value in count.items():
        if key != '0' and key != '-' and key != '1'  and key != '8' and val[max_val] +1  < val[key]:
            anomaly = anomaly + float(val[key])/count[key]
            print("key and anomaly : ",key," ",anomaly)
            freq_count+= count[key]
    print("anomaly", anomaly)
    return (anomaly/(freq_count+1.0))


map1 = dict()
anomaly_single_overshoot = dict()
for key,value in map.items():
    if(len(value) == 1):
        stringValue = value[0].split(":")
        if(stringValue[0] == "u" or  stringValue[0] == "v" or  stringValue[0] == "t"):
            #print("anomaly of strength 4 : ")
            #print(key[0], " to  ", key[1])
            anomaly_single_overshoot[key] = stringValue
    else:
        map1[key] = generatePattern(value)
        
#
#for key,value in map1.items():
#    if(len(value) == 1):
#        stringValue = value[0].split(":")
#        if(stringValue[0] == "u" or  stringValue[0] == "v" or  stringValue[0] == "t"):
#            #print("anomaly of strength 4 : ")
#            #print(key[0], " to  ", key[1])
#            anomaly_single_overshoot[key] = stringValue    

anomaly_weight_list = dict()
anomaly_weight_list2 = dict()
for key,value in map1.items():
    anomaly_weight_list[key] = processPattern(value)
    anomaly_weight_list2[key] = processPatternWeight(value)

#occurences = dict()

#for key,value in map1.items():
    
anomaly_weight_list_new = dict()
for key in anomaly_weight_list.keys():  ## creates a list of all keys
   if anomaly_weight_list[key] != deault_min_score:
       anomaly_weight_list_new[key] = anomaly_weight_list[key]

anomaly_weight_list_norm = normalise(anomaly_weight_list_new)
anomaly_weight_list_norm2 = normalise(anomaly_weight_list2)   



    


    
    
            