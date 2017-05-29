#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""

@author: twinklegupta
"""

"""
To generate candidate original map
"""

import pandas as pd
#from igraph import *
import numpy as np

#g = Graph.Read_Ncol("data_1.csv", directed=True)
map = {}
list_files = []
for i in range(1,28):
    list_files = pd.read_csv("dataCand_"+str(i)+".csv", sep='\t', dtype={'X1': np.int64, 'X2': str}, header=None) # mention dtype to improve performance
    print("Read file   ",i)
    for j in range(1, len(list_files)):
        print(j)
        row = list_files.iloc[j,:]
        tup = row[0]
        if not tup in map.keys():
            map[tup] = list()
        map[tup].append(row[1]+":"+str(i))
        
        


