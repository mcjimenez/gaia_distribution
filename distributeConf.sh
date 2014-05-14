################################################################################
#
# Distribute configuration
#
################################################################################

# Gaia directory. Absolute path
MOZ_GAIA_DIR="/home/cjc/dev/gaia"

# Output Directory. Absolute path. It must be exit
DST_OUTPUT="/home/cjc/tmp/test_stageV13"

# Zip file name
OUT_FILE_NAME="gaiaZTE_SPAIN_buildV13.zip"

# List of files (white space separator) that will be included on the zip file
# at the same directory level than the distribution directory
FIRST_LEVEL="README.txt"

# List of files that will not be included on the file zip
EXCL_LST="distribute.sh distributeConf.sh"

# Distribution directory name
DISTRIB_DIR_OUT="gaiaZTE_Spain"

LOCAL_BRANCH="v1.3"
REMOTE_BRANCH="v1.3"
REMOTE_ORIGIN="mozilla"

REMOTE_DIST_ORIGIN="v1.3"

USER_TYPE=1
export MOZ_GAIA_DIR DST_OUTPUT USER_TYPE FIRST_LEVEL EXCL_LST DISTRIB_DIR_OUT
export OUT_FILE_NAME REMOTE_ORIGIN REMOTE_DIST_ORIGIN DIST_BRANCH
export LOCAL_BRANCH REMOTE_BRANCH