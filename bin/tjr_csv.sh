#!/usr/bin/env python

import argparse
import json

parser = argparse.ArgumentParser(description='Parse CSV from stdin and output to stdout, optionally changing the separator.')
parser.add_argument('--sep', type=str, help='separator for input fields',default=',')
parser.add_argument('--outsep', type=str, help='separator for output fields',default='|')

args = parser.parse_args()
#print(args.sep)
#print(json.dumps([args.sep,args.outsep]))

s=json.dumps([args.sep,args.outsep])

# now execute the a.out program with the json string as first argument
import subprocess

subprocess.call(["./tjr_csv.native",s])
