#!/bin/bash


#PUPPET_var_path=`/opt/puppet/bin/puppet config print vardir`
PUPPET_var_path="/"
PUPPET_lock_file="${PUPPET_var_path}/state/puppetdlock"
PUPPET_bootstrap="false"
PUPPET_install="false"
PUPPET_upgrade="false"
PUPPET_master="puppet"

#function to bootstrap

puppet_bootstrap(){
  loop_timeout=320
  loop_time=0

  echo "checking for lock file"

  while [ -f $PUPPET_lock_file ]
  do
    echo "lock file found, waiting"
    sleep 15
    loop_time=$loop_time + 15
    if [ $loop_time == $loop_timeout ]
    then
      exit "150 - timeouut exceeded"
    fi
  done

  echo "Now running puppet"

  if [ $PUPPET_install=='true' ]
  then
    FACTER_pe_install="true"
    echo /opt/puppet/bin/puppet agent -t --environment=pe_agent \
      --server="${PUPPET_master}" \
      --ssldir="/etc/puppetlabs/puppet/ssl"
  elif [ $PUPPET_upgrade=='true' ]
  then
    FACTER_pe_upgrade="true"
    echo /opt/puppet/bin/puppet agent -t --environment=pe_agent
  fi

}



#check if we are the forked process or the puppet triggered one

for options in $*
do
  case $options in
    --install=*)
      PUPPET_install=${*=}
      ;;
    --upgrade=*)
      PUPPET_upgrade=${*=}
      ;;
    --master=*)
      PUPPET_master=${*=}
      ;;
    --bootstrap=*)
      PUPPET_bootstrap=${*=}
      ;;
    *)
      #unknown
      ;;
  esac
done

if [ $PUPPET_bootstrap=='false' ]
then
  echo /opt/puppet/bin/PUPPET_bootstrap.sh --install=$PUPPET_install \
    --upgrade=$PUPPET_upgrade \
    --master=$PUPPET_master \
    --bootstrap=true &
else
  puppet_bootstrap
fi











