#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_4
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_4.ER
#PBS -o ./test/PBS_batcher_test_4.OU

echo "PBS batcher job 4 says: d"

