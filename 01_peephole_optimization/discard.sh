#!/bin/bash

set -e

lab_dir=`dirname $0`
llvm_repo_dir=${lab_dir}/../llvm-project

rm -r ${llvm_repo_dir}/llvm/lib/Transform/PeepholeOptimization
cp ${lab_dir}/llvm/lib/Transform/CMakeLists.txt.bak ${llvm_repo_dir}/llvm/lib/Transform/CMakeLists.txt

echo "[01_peephole_optimization] Patch discarded. Please rebuild llvm-project."
