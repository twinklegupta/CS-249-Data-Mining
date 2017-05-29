#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: twinklegupta
"""

"""
To generate dom 2 com original map
"""
import pandas as pd
#from igraph import *
import numpy as np

#g = Graph.Read_Ncol("data_1.csv", directed=True)
map = {}
list_files = []
for i in range(1,28):
    list_files = pd.read_csv("data_"+str(i)+".csv", sep='\t', dtype={'X1': np.int64, 'X2': np.int64, 'X3':str}, header=None) # mention dtype to improve performance
    for j in range(1, len(list_files)):
        row = list_files.iloc[j,:]
        tup = (row[0],row[1])
        if not tup in map.keys():
            map[tup] = list()
        map[tup].append(row[2]+":"+str(i))
        
        