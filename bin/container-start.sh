#!/bin/bash
if [ -z "${JBOSS_FUSE}" ] ; then
echo "Please, execute: export JBOSS_FUSE=/path/to/jboss/fuse"
exit 1
fi

TMP_CONTAINERS="/tmp/$$.fuse.containers"
FUSE_CLIENT=${JBOSS_FUSE}/bin/client
${FUSE_CLIENT} container-list 2> /dev/null | grep karaf > $TMP_CONTAINERS
containers=$(awk '/fvg/ {print $1}' $TMP_CONTAINERS)
for container in $containers ; do
echo ${FUSE_CLIENT} container-start $container 
${FUSE_CLIENT} container-start $container 
done
rm $TMP_CONTAINERS
