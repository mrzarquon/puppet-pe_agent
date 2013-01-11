puppet-pe_agent
===============

PE Agent installer / updater module

Works and tested for centos 6 x86_64

Assumes you have an environment called pe_boostrap, with site.pp assign default node to pe_agent, and modules/pe_agent symlinked to the modules real location on your server.

A future class enabled.pp will create the environment on your master if you apply it (ie pe_agent::enabled).

The idea around the package layout is to make them auto-buildable as possible, so the idea would be:

    %releasenumber%
    |-- %OSfamily%.pp
    |-- Packages
        |-- %OSFamily%_%OSrevision%_%Architecture%.pp

In theory, this means that new realeases of PE just need to be added to the existing manifests directory in the form of a single folder named after the release number.


    puppet-pe_agent/
    ├── README.md
    ├── ext
    │   └── generate_packages.rb
    ├── files
    │   ├── PUPPET_bootstrap.sh
    │   └── site.pp
    ├── lib
    │   ├── facter
    │   │   └── pe_version.rb
    │   └── puppet
    │       └── module_cwd.rb
    ├── manifests
    │   ├── 2.6.1
    │   │   ├── el.pp
    │   │   └── packages
    │   │       ├── el_5_x86_64.pp
    │   │       └── el_6_x86_64.pp
    │   ├── config.pp
    │   ├── enabled.pp
    │   ├── init.pp
    │   ├── params.pp
    │   └── yum.pp
    └── templates
        └── puppet.conf.erb


