#!/bin/bash -l

set -exo pipefail

function activate_standby() {
    gpstop -may -M immediate
    export PGPORT=6001
    export MASTER_DATA_DIRECTORY=/home/gpadmin/gpdb_src/gpAux/gpdemo/datadirs/standby
    gpactivatestandby -ad $MASTER_DATA_DIRECTORY
}

function _main() {
    tar -xzf /home/gpadmin/bin_postgresql-hll/postgresql-hll-*_x86_64.tar.gz -C /usr/local/greenplum-db-devel
    source /home/gpadmin/gpdb_src/gpAux/gpdemo/gpdemo-env.sh

    pushd /home/gpadmin/postgresql-hll_src
    # Show regress diff if test fails
    export SHOW_REGRESS_DIFF=1
    time make installcheck
    popd
}

_main
