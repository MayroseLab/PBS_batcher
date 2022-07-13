#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_10
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_10.ER
#PBS -o ./test/PBS_batcher_test_10.OU

echo "PBS batcher job 10 says: j"

