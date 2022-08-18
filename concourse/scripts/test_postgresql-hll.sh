#!/bin/bash -l

set -exo pipefail

function _main() {
    unpack_dir=/home/gpadmin/bin_postgresql-hll/postgresql-hll_unpack
    mkdir -p ${unpack_dir}
    tar -xzf /home/gpadmin/bin_postgresql-hll/postgresql-hll-*_x86_64.tar.gz -C ${unpack_dir}
    ${unpack_dir}/install_gpdb_component

    source /home/gpadmin/gpdb_src/gpAux/gpdemo/gpdemo-env.sh

    pushd /home/gpadmin/postgresql-hll_src
    time make installcheck
    popd
}

_main
