#!/bin/bash
#PBS -S /bin/bash
#PBS -N PBS_batcher_test_8
#PBS -r y
#PBS -q itaym
#PBS -V
#PBS -e ./test/PBS_batcher_test_8.ER
#PBS -o ./test/PBS_batcher_test_8.OU

echo "PBS batcher job 8 says: h"

