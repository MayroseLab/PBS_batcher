#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_2
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_2.ER
#PBS -o ./test/PBS_batcher_test_2.OU

echo "PBS batcher job 2 says: b"

