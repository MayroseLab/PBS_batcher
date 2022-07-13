#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_6
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_6.ER
#PBS -o ./test/PBS_batcher_test_6.OU

echo "PBS batcher job 6 says: f"

