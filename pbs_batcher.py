#!/usr/bin/env python

import os
import sys
import argparse
import re
import getpass
import subprocess
from time import sleep
import pandas as pd

def compute_curr_jobs_num():
    username = getpass.getuser()
    proc = subprocess.run(
        f"qselect -u {username} | wc -l",
        shell=True,
        check=True,
        capture_output=True
    )
    curr_jobs_num = int(proc.stdout)
    return curr_jobs_num

def parallel_job_run(commands_list, max_parallel_jobs=300, check_time=120):
    job_index = 0
    while job_index < len(commands_list):
        while compute_curr_jobs_num() > max_parallel_jobs:
            sleep(check_time)
        os.system(commands_list[job_index])
        if job_index % 100 == 0:
            print(f"submitted {job_index} jobs thus far")
        job_index += 1
    return 0

def detect_wildcards(txt):
    wc_regex = re.compile(r'<(\w+)>')
    return list(set(wc_regex.findall(txt)))

def replace_by_dict(s, d):
    for key, val in d.items():
        s = s.replace(str(key), str(val))
    return s

def commands_from_list(sh_list):
    with open(sh_list) as f:
        commands_list = ['qsub ' + l.strip() for l in f.readlines()]
        return commands_list

def commands_from_template(template, values_tsv, sh_dir=None):

    # Read template
    with open(template) as f:
        template_text = f.read()
    wildcards = sorted(detect_wildcards(template_text))

    # Read values TSV
    values_df = pd.read_csv(values_tsv, sep='\t')
    value_names = sorted(list(values_df.columns))
    err_msg = f"""
    Wildcards names as indicated in template is different than the value names!
    Wildcards: {wildcards}
    Values: {value_names}
    """
    assert wildcards == value_names, err_msg
    
    commands_list = []
    # Create sh text
    if sh_dir and not os.path.isdir(sh_dir):
        os.makedirs(sh_dir)
    for row in values_df.iterrows():
        values_dict = row[1].to_dict()
        values_dict = {'<%s>' % v : values_dict[v] for v in values_dict}
        job_text = replace_by_dict(template_text, values_dict)
        job_ind = str(row[0])
        if sh_dir:
            sh_file = os.path.join(sh_dir, f'job{job_ind}.sh')
            with open(sh_file, 'w') as fo:
                print(job_text, file=fo)
            cmd = f'qsub {sh_file}'
        else:
            cmd = f'qsub <<< {job_text}'
        commands_list.append(cmd)
    return commands_list

if __name__ == "__main__":

    # Command line args
    parser = argparse.ArgumentParser(description='PBS batcher')
    parser.add_argument('-j', '--jobs', type=int, required=True, help='Batch size (max number of jobs')
    parser.add_argument('--sh_list', default=None, help='Path to file containing list of sh files')
    parser.add_argument('--template', default=None, help='Path to template file')
    parser.add_argument('--values_tsv', default=None, help='Path to values TSV')
    parser.add_argument('--sh_dir', default=None, help='Directory to save sh files (if not provided, will submit directly)')
    parser.add_argument('--check_time', default=120, type=int, help='How often to check the number of running jobs (in seconds; default: 120)')

    args = parser.parse_args()

    assert (args.sh_list and not(args.template or args.values_tsv)) or (not args.sh_list and (args.template and args.values_tsv)), 'Must provide either sh_list or both template and values_tsv'


    if args.sh_list:
        commands_list = commands_from_list(args.sh_list)

    else:
        commands_list = commands_from_template(args.template, args.values_tsv, args.sh_dir)

    parallel_job_run(commands_list, max_parallel_jobs=args.jobs, check_time=args.check_time) 
