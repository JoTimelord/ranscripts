import os, sys
import ROOT
import shutil
import argparse

ROOT.gROOT.SetBatch(True)

# Initialize parser
parser = argparse.ArgumentParser()

# Adding optional argument
parser.add_argument("-i", "--input", help = "Enter directory name")


# Read arguments from command line
args = parser.parse_args()
no = 0

for root, dirs, files in os.walk(args.input):
    for file in files:
        if file.endswith(".root"):
            name = os.path.join(root, file)
            newpath = args.input+"/output"+str(no)+".root"
            os.rename(name, newpath)
            print (name)
            print ("after renaming: " + newpath)
            no+=1



