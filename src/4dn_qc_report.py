#!/usr/bin/env python

# Author: Clara Bakker

import json
import argparse

def main(args):
    qc_file = args.in_qc_json
    outfile = args.out_qc_json

    with open(qc_file, 'r') as f:
        qc_json = json.load(f)

    # pop out fields specified by the list
    rm_fields = ["general", "align_enrich"]
    [qc_json.pop(field, None) for field in rm_fields]

    with open(outfile, 'w') as f:
        json.dump(qc_json, f, indent=4)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("--in_qc_json", type=str, help="path/to/qc.json")
    parser.add_argument("--out_qc_json", type=str, help="path/to/out.json")
    args = parser.parse_args()
    main(args)
