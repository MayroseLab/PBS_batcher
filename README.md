# PBS batcher
Send batches of jobs to PBS scheduler.  

Given a large number of jobs that you need to submit, this script allows you to specify the maximal number of jobs to be in the queue at a time. E.g.: you need to run 10,000 jobs, but you don't want to "flood" the queue, so you only want 300 to be present in the queue at each time.  

## Getting started
**Dependencies:**
* python 3
* pandas

```
$ git clone git@github.com:MayroseLab/PBS_batcher.git
$ cd PBS_batcher
$ python pbs_batcher.py -h
```

## Usage
There are two ways to use the script: 1) using a list of pre-generated sh files, or 2) using a template and letting the script generate the commands automatically.  
To use pre-generated sh files, simply create a file containing full paths to sh files, one per line. Then run:
```
$ python pbs_batcher.py -j 10 --sh_list sh_list.txt
```
where `-j 10` indicates a maximum of 10 jobs at a time.  

To run using a template, you'll need to generate two inputs:
1. Template sh - an sh file as usually submitted, containing all relevant commands and parameters. The template may contain *wildcards* - strings enclosed by triangle brackets, e.g. `<VALUE>` or `<name>` - you can use any name you want and any number of different wildcards. You can use the same wildcard multiple times.
2. Values TSV - a tab-separated values file, with column names matching the wildcards found in the template (without the brackets), e.g. `VALUE` or `name`. Each row represents a job to be submitted, where wildcards in the template will be replaced by the values in the row.
Once you prepare these inputs, run:
```
$ python pbs_batcher.py -j 5 --template template.sh --values_tsv values.tsv --sh_dir sh_dir
```
The script will generate sh files and store them in sh_dir.  
Run `python pbs_batcher.py -h` for other options.  
It is recommended to submit the batcher script as a PBS job, which will submit new jobs.

## Test/example
You can try the script on a toy example by running:
```
python pbs_batcher.py -j 3 --sh_list test/sh_list.txt --check_time 5
```
or
```
python pbs_batcher.py -j 3 --template test/template.sh --values_tsv test/values.tsv --sh_dir test/sh_dir --check_time 5
```
