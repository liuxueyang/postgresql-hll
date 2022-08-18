#!/bin/bash

echo begining of build.sh: OS_NAME=${OS_NAME}

set -exo pipefail

CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOP_DIR=${CWDIR}/../../../

source "${TOP_DIR}/gpdb_src/concourse/scripts/common.bash"
function pkg() {
    echo ${OS_NAME}
    [ -f /opt/gcc_env.sh ] && source /opt/gcc_env.sh
    source /usr/local/greenplum-db-devel/greenplum_path.sh

    pushd /home/gpadmin/postgresql-hll_src
    make
    make install
    popd

    mkdir -p $TOP_DIR/bin_postgresql-hll

    CURRENT_VERSION=$(cat /home/gpadmin/postgresql-hll_src/VERSION)
    echo ${OS_NAME}
    $CWDIR/pack.sh -p /usr/local/greenplum-db-devel/ -f "$TOP_DIR/bin_postgresql-hll/postgresql-hll-${CURRENT_VERSION}-${OS_NAME}_x86_64.tar.gz"
    cp "$TOP_DIR/bin_postgresql-hll/postgresql-hll-${CURRENT_VERSION}-${OS_NAME}_x86_64.tar.gz" "$TOP_DIR/bin_postgresql-hll/postgresql-hll.tar.gz"
}

function _main() {
    echo ${OS_NAME}
    . /home/gpadmin/.bashrc
    echo ${OS_NAME}
    time pkg
}

_main "$@"
