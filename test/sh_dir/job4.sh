#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_5
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_5.ER
#PBS -o ./test/PBS_batcher_test_5.OU

echo "PBS batcher job 5 says: e"

