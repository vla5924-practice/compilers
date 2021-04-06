#!/bin/bash

set -e

lab_dir=`dirname $0`
repo_dir=`realpath ${lab_dir}/..`

success_msg="[01_peephole_optimization] Patch applied. Please rebuild llvm-project."

if [[ $1 -eq "-a" ]]; then
    cp -r ${lab_dir}/llvm-project ${repo_dir}
    echo $success_msg
    exit 0
fi

patch_dir=${lab_dir}/llvm-project
llvm_dir=${repo_dir}/llvm-project
transform_path="llvm/lib/Transform"

if cmp --silent -- "${patch_dir}/${transform_path}/CMakeLists.txt" "${llvm_dir}/${transform_path}/CMakeLists.txt"; then
else
  cp "${patch_dir}/${transform_path}/CMakeLists.txt" "${llvm_dir}/${transform_path}/CMakeLists.txt"
fi

if cmp --silent -- "${patch_dir}/${transform_path}/PeepholeOptimization/CMakeLists.txt" "${llvm_dir}/${transform_path}/PeepholeOptimization/CMakeLists.txt"; then
else
  cp "${patch_dir}/${transform_path}/PeepholeOptimization/CMakeLists.txt" "${llvm_dir}/${transform_path}/PeepholeOptimization/CMakeLists.txt"
fi

cp ${patch_dir}/${transform_path}/PeepholeOptimization/*.cpp ${llvm_dir}/${transform_path}/PeepholeOptimization/

echo $success_msg
