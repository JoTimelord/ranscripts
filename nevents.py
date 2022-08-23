
import os, sys
import ROOT
import argparse

ROOT.gROOT.SetBatch(True)

# Initialize parser
parser = argparse.ArgumentParser()

# Adding optional argument
parser.add_argument("-f", "--file", help = "Enter directory name")

# Read arguments from command line
args = parser.parse_args()

nevents = 0

for root, dirs, files in os.walk(args.file):
    for file in files:
        if file.endswith(".root"):
            name = os.path.join(root, file)
            print (name)
            fi = ROOT.TFile.Open(name, "READ")
            tree = fi.Get("Events")
            print (tree.GetEntries())
            nevents += tree.GetEntries()

print (nevents)


