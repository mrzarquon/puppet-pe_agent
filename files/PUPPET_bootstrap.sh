#!/bin/bash
PUPPET_var_path=`/opt/puppet/bin/puppet config print vardir`
PUPPET_lock_file="${PUPPET_var_path}/state/puppetdlock"
PUPPET_bootstrap="false"
PUPPET_install="false"
PUPPET_upgrade="false"
PUPPET_master="puppet"

# function to bootstrap
# This is the meat of the program. This block of code is *only* called from the 
# either the exec calling it without -b, which causes it to fork an instance of
# itself with the -b flag, or it being called from the command line with -b.
# Running with -b means that we want to perform the puppet run against the
# pe_bootstrap environment that exists on the designated puppet master, as long
# as the puppet daemon itself still isn't in the middle of a run.

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
  echo $PUPPET_install
  echo $PUPPET_install
  if [ "${PUPPET_install}" == 'true' ]
  then
    export FACTER_pe_install="true"
    echo "starting puppet install" 
    /opt/puppet/bin/puppet agent -t --environment=pe_bootstrap \
      --server="${PUPPET_master}" \
      --ssldir="/etc/puppetlabs/puppet/ssl"
  elif [ "${PUPPET_upgrade}" == 'true' ]
  then
    export FACTER_pe_upgrade="true"
    echo "starting puppet upgrade"
    /opt/puppet/bin/puppet agent -t --environment=pe_bootstrap
  fi

}



#check if we are the forked process or the puppet triggered one
# Flag summary:
# -u : performing an upgrade, no need to modify puppet.conf
# -i : performing install, so assume puppet.conf needs to be managed
# -m : provides the master that the puppet run should be done against
# -b : indicates to perform the bootstrap, only done from this script
#      or a commandline invocation

#arg string
arg_string=""

while getopts ":uib:m:" opt; do
  case $opt in
    u)
      echo "upgrade"
      arg_string=$arg_string"-u "
      PUPPET_upgrade="true"
      ;;
    i)
      echo "install"
      arg_string=$arg_string"-i "
      PUPPET_install="true"
      ;;
    b)
      echo "bootstrap"
      arg_string=$arg_string"-b "
      PUPPET_bootstrap="true"
      ;;
    m)
      echo "master"
      arg_string=$arg_string"-m ${OPTARG} "
      PUPPET_master=$OPTARG
      ;;
    :)
      echo "Needs arguments"
      ;;
  esac
done

# Are we bootstraping? if so, do it. If not, fork with -b to ensure the forked
# process bootstraps for us. This allows daemonized puppet to report to the master
# that it triggered the bootstrap, and then have the node immediately run the bootstrap
# once the daemonized run completes.
if [ "${PUPPET_bootstrap}" == 'false' ]
then
  /opt/puppet/bin/PUPPET_bootstrap -b $arg_string &
else
  puppet_bootstrap
fi

