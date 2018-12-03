#Written by Austin (Seung Min) Moon for the Working Memory and Plasticity Lab
#Email moonsm@uci.edu for more questions

import re, csv, os, os.path
import numpy as np
from scipy import stats
import glob
import shutil

input = "timestamp_clean.csv"
output = "spacing_clean.csv"

pid = glob.glob('[0-9][0-9][0-9]')
reader = csv.DictReader(open(input,'rU'))

if os.path.exists(output):
    writer = csv.writer(open(output, 'ab'))  # open filewriter
else:
    writer = csv.writer(open(output, 'wb'))
    writer.writerow(['PID','# of Sessions','Median','# of Median','average_space','SD','Mode','Mode #','Max','Max #','Min','Min #'])

i = 0
average_space = []

for row in reader:
    if row["PID"] == pid[i]:
        if row["Spaced"] == "NaN":
            continue
        else:
            average_space.append(int(row["Spaced"]))
    else:
        print("Calculating "+pid[i])
        #print(average_space)
        average = np.mean(average_space)
        SD = np.std(average_space)
        total_ses = len(average_space)+1
        the_median = np.median(average_space)
        the_ceil = np.max(average_space)
        the_floor = np.min(average_space)
        the_mode = np.bincount(average_space).argmax()
        writer.writerow([pid[i],total_ses,the_median,average_space.count(the_median),average,SD,the_mode,average_space.count(the_mode),the_ceil,average_space.count(the_ceil),the_floor,average_space.count(the_floor)])
        average_space = []
        i += 1
print("Calculating "+pid[i])
print(average_space)
average = np.mean(average_space)
SD = np.std(average_space)
total_ses = len(average_space)+1
the_median = np.median(average_space)
the_ceil = np.max(average_space)
the_floor = np.min(average_space)
the_mode = np.bincount(average_space).argmax()
writer.writerow([pid[i],total_ses,the_median,average_space.count(the_median),average,SD,the_mode,average_space.count(the_mode),the_ceil,average_space.count(the_ceil),the_floor,average_space.count(the_floor)])
