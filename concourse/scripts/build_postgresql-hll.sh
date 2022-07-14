#!/bin/bash -l

set -exo pipefail

CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TOP_DIR=${CWDIR}/../../../

source "${TOP_DIR}/gpdb_src/concourse/scripts/common.bash"
function pkg() {
    [ -f /opt/gcc_env.sh ] && source /opt/gcc_env.sh
    source /usr/local/greenplum-db-devel/greenplum_path.sh

    if [ "${POSTGRESQL_HLL_OS}" = "rhel6" ]; then
        export CC="$(which gcc)"
    fi

    pushd /home/gpadmin/postgresql-hll_src
    # local last_release_path
    # last_release_path=$(readlink -e /home/gpadmin/last_released_postgresql-hll_bin/postgresql-hll-*.tar.gz)
    make clean
    make
    make install
    popd

    pushd /usr/local/greenplum-db-devel/
    echo 'cp -r lib share $GPHOME || exit 1'> install_gpdb_component
    chmod a+x install_gpdb_component
    mkdir -p $TOP_DIR/postgresql-hll_artifacts
    tar -czf "$TOP_DIR/postgresql-hll_artifacts/postgresql-hll-${POSTGRESQL_HLL_OS}_x86_64.tar.gz" \
        "lib/postgresql/hll.so" \
        "share/postgresql/extension/hll.control" \
        "share/postgresql/extension/hll--2.10.sql" \
        "share/postgresql/extension/hll--2.11.sql" \
        "share/postgresql/extension/hll--2.12.sql" \
        "share/postgresql/extension/hll--2.13.sql" \
        "share/postgresql/extension/hll--2.14.sql" \
        "share/postgresql/extension/hll--2.15.sql" \
        "share/postgresql/extension/hll--2.16.sql" \
        "share/postgresql/extension/hll--2.10--2.11.sql" \
        "share/postgresql/extension/hll--2.11--2.12.sql" \
        "share/postgresql/extension/hll--2.12--2.13.sql" \
        "share/postgresql/extension/hll--2.13--2.14.sql" \
        "share/postgresql/extension/hll--2.14--2.15.sql" \
        "share/postgresql/extension/hll--2.15--2.16.sql" \
        "install_gpdb_component"
    popd
    cp "$TOP_DIR/postgresql-hll_artifacts/postgresql-hll-${POSTGRESQL_HLL_OS}_x86_64.tar.gz" "$TOP_DIR/postgresql-hll_artifacts/postgresql-hll.tar.gz"
}

function _main() {
    time pkg
}

_main "$@"
