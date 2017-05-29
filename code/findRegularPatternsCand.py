#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Sun Mar 12 16:17:55 2017

@author: twinklegupta
"""

"""
Only candidates
single overshoot - to be done
jitter overshoot
trend

"""
from collections import Counter
import re

deault_min_score = -1000   #-300

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

#candidate suddenly receives high amount
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



def processPattern(pattern):
    pattern_stripped = pattern.strip('0')
    length_stripped = len(pattern_stripped)
    num_zeros = pattern_stripped.count('0') 
    length_trailing_zeros = len(pattern) - len(pattern.rstrip('0'))
    loyalty_score = (float)(length_stripped-num_zeros)/(length_stripped+length_trailing_zeros)
    if loyalty_score == 1 and length_trailing_zeros == 0:
        return deault_min_score
    max_consec_zeros  =0
    patterns = re.findall(r'0+', pattern_stripped)
    if len(patterns) != 0:
         max_consec_zeros = max(len(s) for s in patterns)
    leverage_score = 0
    add_score = (float)(length_trailing_zeros)/length_stripped
    if loyalty_score != 0:
        leverage_score = (float)(max_consec_zeros + add_score)/loyalty_score
    return (-leverage_score)




def normalise(myDict):
    df = pd.DataFrame.from_dict(myDict, orient='index').reset_index()
    df_norm = (df[0] - df.min()[1])/(df.max()[1] - df.min()[1])
    df[0] = df_norm
    return df


map1 = dict()
anomaly_single_overshoot = dict()
for key,value in map.items():
    if(len(value) == 1):
        stringValue = value[0].split(":")
        print("Value is : ", stringValue)
        if(stringValue[0] == "u" or  stringValue[0] == "v" or  stringValue[0] == "t"):
            anomaly_single_overshoot[key] = stringValue   # No overshoot
    else:
        map1[key] = generatePattern(value)

#anomaly_single_overshoot = dict()
#map2 = dict()
#
#for key,value in map.items():
#    if(len(value) >= 4):
#        map2[key] = generatePattern(value)

anomaly_weight_list = dict()
for key,value in map1.items():
    anomaly_weight_list[key] = processPatternWeight(value)


normalized_anomaly_weight = normalise(anomaly_weight_list)

#threshold = 0.75

#anomalies = normalized_anomaly_weight[(normalized_anomaly_weight >= threshold).all(axis=1)]


anomaliesProcessPattern = dict()
for key,value in map1.items():
    anomaliesProcessPattern[key] = processPattern(value)
#    if len(value) != 1:


anomaliesProcessPattern_new = dict()
for key in anomaliesProcessPattern.keys():  ## creates a list of all keys
   if anomaliesProcessPattern[key] != deault_min_score:
       anomaliesProcessPattern_new[key] = anomaliesProcessPattern[key]


normalized_anomaliesProcessPattern = normalise(anomaliesProcessPattern_new)


threshold = 0.995

anomaliesFinalProcessPattern = normalized_anomaliesProcessPattern[(normalized_anomaliesProcessPattern >= threshold).all(axis=1)]


normalized_anomaliesProcessPattern.to_csv("Cand_loyalty_lev_original.csv")

modify_this = dict()
for key,value in map.items():
    if(len(value) == 1):
        modify_this[key] = value
        