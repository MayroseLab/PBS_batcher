#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_<n>
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_<n>.ER
#PBS -o ./test/PBS_batcher_test_<n>.OU

echo "PBS batcher job <n> says: <msg>"
