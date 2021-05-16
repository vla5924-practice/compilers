#!/bin/bash

set -e

lab_dir=`dirname $0`
llvm_repo_dir=${lab_dir}/../llvm-project

cp ${lab_dir}/llvm/lib/Transform/Scalar/LICM.cpp.bak ${llvm_repo_dir}/llvm/lib/Transform/Scalar/LICM.cpp
rm ${llvm_repo_dir}/llvm/lib/Transform/Scalar/LICM.cpp.bak

echo "[02_loop_invariant_code_motion] Patch discarded. Please rebuild llvm-project."
