#! /bin/bash

if [ "$(id -u)" != "0" ]; then
echo "you need to be root"
exit
fi

if [ -z "${JBOSS_FUSE}" ] ; then
	echo "Please, execute export JBOSS_FUSE=/path/to/jboss/fuse"
	exit 1
fi 

if [ ! -d ${JBOSS_FUSE} ] ; then
echo "${JBOSS_FUSE} does not exist"
exit 2
fi

if [ !  -f "${JBOSS_FUSE}/bin/fuse" ] ; then
echo "${JBOSS_FUSE}/bin/fuse does not exist. Wrong jboss fuse path?"
exit 3
fi

TMP=/tmp/.fuse_init.$$
mkdir $TMP
cp bin/jbossFuse-service.template ${TMP}/service
cp etc/jbossFuse-wrapper.conf.template ${TMP}/wrapper

sed -i "s,%JBOSS_FUSE%,${JBOSS_FUSE},g" ${TMP}/service 
sed -i "s,%JBOSS_FUSE%,${JBOSS_FUSE},g" ${TMP}/wrapper
cp ${TMP}/service ${JBOSS_FUSE}/bin
cp ${TMP}/wrapper ${JBOSS_FUSE}/etc
cp bin/jbossFuse-wrapper ${JBOSS_FUSE}/bin
rm -rf ${TMP}

ln -s ${JBOSS_FUSE}/jbossFuse-service /etc/init.d/
chkconfig jbossFuse-service --add
chkconfig jbossFuse-service on
