puppet-pe_agent
===============

PE Agent installer / updater module

Works and tested for centos 6 x86_64

Assumes you have an environment called pe_boostrap, with site.pp assign default node to pe_agent, and modules/pe_agent symlinked to the modules real location on your server.

A future class enabled.pp will create the environment on your master if you apply it (ie pe_agent::enabled).


