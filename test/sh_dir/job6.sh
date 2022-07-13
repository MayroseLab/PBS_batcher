#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_7
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_7.ER
#PBS -o ./test/PBS_batcher_test_7.OU

echo "PBS batcher job 7 says: g"

