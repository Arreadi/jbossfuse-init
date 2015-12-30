#!/bin/bash
if [ -z "${JBOSS_FUSE}" ] ; then
echo "Please, execute: export JBOSS_FUSE=/path/to/jboss/fuse"
exit 1
fi
if [ -z "$1" ] ; then
echo "Please,execute: $0 [start|stop]"
exit 2

fi

case $1 in
stop)
cmd="$1"
;;
start)
cmd="$1"
;;
*)
echo "Please,execute: $0 [start|stop]"
;;
esac


TMP_CONTAINERS="/tmp/$$.fuse.containers"
FUSE_CLIENT=${JBOSS_FUSE}/bin/client
${FUSE_CLIENT} container-list 2> /dev/null | grep karaf > $TMP_CONTAINERS
containers=$(awk '/fvg/ {print $1}' $TMP_CONTAINERS)
for container in $containers ; do
echo ${FUSE_CLIENT} container-${cmd} $container 
${FUSE_CLIENT} container-${cmd} $container 
done
rm $TMP_CONTAINERS
