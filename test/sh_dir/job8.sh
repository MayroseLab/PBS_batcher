#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_9
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_9.ER
#PBS -o ./test/PBS_batcher_test_9.OU

echo "PBS batcher job 9 says: i"

