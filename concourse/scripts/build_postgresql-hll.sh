#!/bin/bash -l

set -exo pipefail

CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOP_DIR=${CWDIR}/../../../

source "${TOP_DIR}/gpdb_src/concourse/scripts/common.bash"
function pkg() {
    [ -f /opt/gcc_env.sh ] && source /opt/gcc_env.sh
    source /usr/local/greenplum-db-devel/greenplum_path.sh

    if [ "${OS_NAME}" = "rhel6" ] || [ "${OS_NAME}" = "rhel7" ]; then
        export CC="$(which gcc)"
    fi

    pushd /home/gpadmin/postgresql-hll_src
    make clean

    echo $CC
    echo $(which gcc)
    gcc --version

    make
    make install
    popd

    mkdir -p $TOP_DIR/bin_postgresql-hll

    $CWDIR/pack.sh -p /usr/local/greenplum-db-devel/ -f "$TOP_DIR/bin_postgresql-hll/postgresql-hll-${OS_NAME}_x86_64.tar.gz"
    cp "$TOP_DIR/bin_postgresql-hll/postgresql-hll-${OS_NAME}_x86_64.tar.gz" "$TOP_DIR/bin_postgresql-hll/postgresql-hll.tar.gz"
}

function _main() {
    time pkg
}

_main "$@"
