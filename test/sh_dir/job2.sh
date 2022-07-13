#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_3
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_3.ER
#PBS -o ./test/PBS_batcher_test_3.OU

echo "PBS batcher job 3 says: c"

