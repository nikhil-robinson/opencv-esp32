#!/bin/bash
#
# Build the test app and all examples from the examples directory.
# Expects EXAMPLE_TARGETS and TEST_TARGETS environment variables to be set.
# Each variable is the list of IDF_TARGET values to build the examples and
# the test app for, respectively.
#
# -----------------------------------------------------------------------------
# Safety settings (see https://gist.github.com/ilg-ul/383869cbb01f61a51c4d).

if [[ -n "${DEBUG_SHELL}" ]]
then
    set -x # Activate the expand mode if DEBUG is anything but empty.
fi

if [[ -z "${EXAMPLE_TARGETS}" || -z "${TEST_TARGETS}" ]]
then
    echo "EXAMPLE_TARGETS and TEST_TARGETS environment variables must be set before calling this script"
    exit 1
fi

if [[ -z "${SKIP_GNU_MAKE_BUILD}" ]]
then
    echo "SKIP_GNU_MAKE_BUILD not set, will build with GNU Make based build system as well."
    export SKIP_GNU_MAKE_BUILD=0
fi

set -o errexit # Exit if command failed.
set -o pipefail # Exit if pipe failed.
set -o nounset # Exit if variable not set.


STARS='***************************************************'

# -----------------------------------------------------------------------------

die() {
    echo "${1:-"Unknown Error"}" 1>&2
    exit 1
}

# build_for_targets <target list>
# call this in the project directory
function build_for_targets
{
    target_list="$1"
    for IDF_TARGET in ${target_list}
    do
        echo "${STARS}"
        echo "Building in $PWD with CMake for ${IDF_TARGET}"
        rm -f sdkconfig
        idf.py set-target "${IDF_TARGET}"
        idf.py build || die "CMake build in ${PWD} has failed for ${IDF_TARGET}"
        idf.py fullclean || true
    done
}

# Build the examples
pushd examples
EXAMPLES=$(find . -maxdepth 1 -mindepth 1 -type d | cut -d '/' -f 2)
for NAME in ${EXAMPLES}
do
    pushd "${NAME}"
    build_for_targets "${EXAMPLE_TARGETS}"
    popd
done
popd
