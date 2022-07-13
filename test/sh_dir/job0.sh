#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_1
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_1.ER
#PBS -o ./test/PBS_batcher_test_1.OU

echo "PBS batcher job 1 says: a"

