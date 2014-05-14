################################################################################
#
# Distribute configuration
#
################################################################################

# Gaia directory. Absolute path
MOZ_GAIA_DIR="/home/cjc/dev/gaiaDEV"

# Gaia distribution dir. Absolute path
DISTRIBUTION_DIR="/home/cjc/dev/distrib/firefoxos-gaia-zte"

# Output Directory. Absolute path. It must be exit
DST_OUTPUT="/home/cjc/tmp/test_stageVmaster"

# Zip file name
OUT_FILE_NAME="gaiaZTE_SPAIN_buildVmaster.zip"

# List of files (white space separator) that will be included on the zip file
# at the same directory level than the distribution directory
FIRST_LEVEL="README.txt"

# List of files that will not be included on the file zip
EXCL_LST="distribute.sh distributeConf.sh"

# List of files that will be included on distribution file
SV_DISTR_LST="__svoperapps"

# Distribution directory name
DISTRIB_DIR_OUT="gaiaZTE_Spain"

LOCAL_BRANCH="master"
REMOTE_BRANCH="master"

REMOTE_ORIGIN="mozilla"

REMOTE_DIST_ORIGIN="origin"

BUILD_STAGE_DIR="build_stage"
USER_TYPE=1
export MOZ_GAIA_DIR DST_OUTPUT USER_TYPE FIRST_LEVEL EXCL_LST DISTRIB_DIR_OUT
export OUT_FILE_NAME SV_DISTR_LST BUILD_STAGE_DIR LOCAL_BRANCH REMOTE_BRANCH
export REMOTE_DIST_ORIGIN DISTRIBUTION_DIR REMOTE_ORIGIN