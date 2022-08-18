#!/bin/bash -l

set -exo pipefail

function _main() {
    tar -xzf /home/gpadmin/bin_postgresql-hll/postgresql-hll-*_x86_64.tar.gz -C /usr/local/greenplum-db-devel
    source /home/gpadmin/gpdb_src/gpAux/gpdemo/gpdemo-env.sh

    pushd /home/gpadmin/postgresql-hll_src
    time make installcheck
    popd
}

_main
