#!/usr/bin/env bash

# Intended to be user configurable
# Required
if [ -z "${SRC_DIR}" ]; then
    echo "You must define the SRC_DIR environment variable. Exiting."
    exit
fi

# need to work in src dir in order for includecodeblock
# to work
cd "${SRC_DIR}"

# Not intended to be user configurable
BOOTSTRAP_DIR="/doc_bootstrap"
OUTPUT_DIR="/site"
GEMFILE_NAME="Gemfile"
GEMFILE_LOCK_NAME="${GEMFILE_NAME}.lock"
DEFAULT_GEMFILE="${BOOTSTRAP_DIR}/${GEMFILE_NAME}"
DEFAULT_GEMFILE_LOCK="${BOOTSTRAP_DIR}/${GEMFILE_LOCK_NAME}"

SRC_GEMFILE="${SRC_DIR}/${GEMFILE_NAME}"
SRC_GEMFILE_LOCK="${SRC_DIR}/${GEMFILE_LOCK_NAME}"
REMOVE_GEMFILE=false
CHOWN=false

# If source Gemfile does not exist, copy over the default (and lock file)
# for the unidata-jekyll-theme
if [ ! -f "${SRC_GEMFILE}" ]; then
    cp ${DEFAULT_GEMFILE} ${SRC_GEMFILE}
    cp ${DEFAULT_GEMFILE_LOCK} ${SRC_GEMFILE_LOCK}
    REMOVE_GEMFILE=true
else
    bundle install
fi

# attach jekyll to 0.0.0.0 so that jekyll serve can
# be outside of the container
ARG=${1}
if [ "${ARG}" = "serve" ] ; then
    ARG="serve --host 0.0.0.0"
else
    CHOWN=true
fi

if [[ ! -e "${OUTPUT_DIR}" ]]; then
    mkdir "${OUTPUT_DIR}"
fi

bundle exec jekyll ${ARG} --destination "${OUTPUT_DIR}"

if [ "${REMOVE_GEMFILE}" = true ] ; then
    rm "${SRC_GEMFILE}"
    rm "${SRC_GEMFILE_LOCK}"
fi

if [ "${CHOWN}" = true ] ; then
    chown -R ${DOCS_UID} "${OUTPUT_DIR}"
fi