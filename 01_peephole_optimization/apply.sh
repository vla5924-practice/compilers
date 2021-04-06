#!/bin/bash

set -e

lab_dir=`dirname $0`
repo_dir=${lab_dir}/../

cp -r ${lab_dir}/llvm-project ${repo_dir}

echo "[01_peephole_optimization] Patch applied. Please rebuild llvm-project."
