#!/bin/sh

################################################################################
#
# Creates a zip file with that includes the directory resulting of doing a
# STAGE_DIR=dstDir/build_stage GAIA_DISTRIBUTION_DIR=this directory make profile
# and the files in FIRST_LEVEL
#
# The configurable values are on distributeConf.sh
#
# Please do not modify this file
#
################################################################################

. `dirname $0`/distributeConf.sh

if [ ! -d "${DST_OUTPUT}" ] ; then
  echo "Destination directory do no exist, please select a valid one"
  exit 1
fi

updateBranch() {
  modif=`git status | grep modified: |wc -l`
  if [ $modif -eq 0 ] ; then
    git checkout ${3}
    if [ $? -ne 0 ] ; then
      echo "Could not changed to branch ${3}. Please assign the correct value"
      echo "in distributeConf and try again"
      exit 2
    fi
    git pull --rebase ${1} ${2}
    if [ $? -ne 0 ] ; then
      echo "There was an error running:"
      echo "  git pull --rebase ${1} ${2}"
      echo "please resolved it and try again"
      exit 3
    fi
  else
    echo "There are $modif files modified, please commit it first or make pull"
    echo "manually"
    exit 4
  fi
}

# Search parameter 1 in parameter 2. Separator is white space.
contains() {
  if [ $# -lt 2 ]; then
    return 3
  fi
  app=$1
  shift
  for elto in $@
  do
    if [ "$elto" = "$app" ]; then
      return 0
    fi
  done
  return 1
}

#DISTRIBUTION_DIR=`pwd`
DIR_TMP_NAME=`basename ${DST_OUTPUT}`

cd ${DST_OUTPUT}
rm -rf *
if [ $? -ne 0 ] ; then
  echo "Content of ${DST_OUTPUT} could not be delete. Please resolve it and"
  echo "execute again."
  exit 5
fi

mkdir -p ${DIR_TMP_NAME}/${DISTRIB_DIR_OUT}/${BUILD_STAGE_DIR}

cd ${MOZ_GAIA_DIR}

echo "Making build..."
updateBranch ${REMOTE_ORIGIN} ${REMOTE_BRANCH} ${LOCAL_BRANCH}
STAGE_DIR=${DST_OUTPUT}/${DIR_TMP_NAME}/${DISTRIB_DIR_OUT}/${BUILD_STAGE_DIR} \
  GAIA_DISTRIBUTION_DIR=${DISTRIBUTION_DIR} PRODUCTION=${USER_TYPE:=1} \
  make profile

if [ $? -ne 0 ] ; then
  echo "There were errors making profile. Please resolved it and try again"
  exit 6
fi

echo "Done."

echo "Erasing all except sv cache..."
cd ${DST_OUTPUT}/${DIR_TMP_NAME}/${DISTRIB_DIR_OUT}/${BUILD_STAGE_DIR}
for app in `ls`
do
  contains ${app} ${SV_DISTR_LST}
  if [ $? -ne 0 ] ; then
    rm -rf ${app}
  fi
done
echo "Done."

cd ${DST_OUTPUT}/${DIR_TMP_NAME}

for fich in ${FIRST_LEVEL}
do
  cp ${DISTRIBUTION_DIR}/${fich} .
done

for fich in `ls ${DISTRIBUTION_DIR}`
do
  contains ${fich} ${EXCL_LST}
  if [ $? -ne 0 ] ; then
    contains ${fich} ${FIRST_LEVEL}
    if [ $? -ne 0 ] ; then
      cp -r ${DISTRIBUTION_DIR}/${fich} \
            ${DST_OUTPUT}/${DIR_TMP_NAME}/${DISTRIB_DIR_OUT}
    fi
  fi
done

echo "Compressing files..."
zip -r ${OUT_FILE_NAME} *
mv ${OUT_FILE_NAME} ..
cd ..
rm -rf ${DIR_TMP_NAME}

echo "Done.\nThe proccess has finished."