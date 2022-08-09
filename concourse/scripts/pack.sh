#!/bin/bash -l

set -exo pipefail

gp_home=""
file_name=""

while getopts "p:f:h" opt; do
    case $opt in
        h)
            echo "Usage: arg.sh -p gp_home -f tar_file_path"
            exit 0
            ;;
        p)
            gp_home="$OPTARG"
            ;;
        f)
            file_name="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            exit 1
            ;;
    esac
done

if [ -z "$gp_home" ] || [ -z "$file_name" ]; then
    echo "-p and -f option should be required"
    exit 1
fi

source $gp_home/greenplum_path.sh

cd $GPHOME
echo 'cp -r lib share $GPHOME || exit 1'> install_gpdb_component
chmod a+x install_gpdb_component

tar -czf "$file_name" \
    "lib/postgresql/hll.so" \
    "share/postgresql/extension/hll.control" \
    "share/postgresql/extension/hll--2.16.sql" \
    "install_gpdb_component"
