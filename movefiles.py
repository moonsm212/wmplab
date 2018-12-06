import re, csv, os, os.path
import numpy as np
import glob
import shutil


CurrDir = os.getcwd()
filenames = glob.glob('[0-9][0-9][0-9]')

for name in filenames: #each session
    path = CurrDir +'\\'+name
    os.chdir(path)
    files = glob.glob('[0-9][0-9][0-9]---*.csv')
    for i in files:
        shutil.move(i,CurrDir)
