class pe_agent::el {
  #classes are tagged by pe version
  # set yum repo to the master
  include pe_agent::yum

  include pe_agent::params
  $pe_install_version = "2_7_0"
  #$pe_install_version = regsubst($pe_agent::params::pe_install_version, '\.+$', '_')
  
  # determine 5 v 6 , 386 v x64
  case $operatingsystemrelease {
    '6.3': {
      case $hardwaremodel {
        'x86_64': { include "pe_agent::${pe_install_version}::packages::el_6_x86_64" }
        'i386': { include "pe_agent::${pe_install_version}::packages::el_6_i386" }
        default: { fail("unsupported platform") }
      }
    }
    '5.8': {
      case $hardwaremodel {
        'x86_64': { include "pe_agent::${pe_install_version}::packages::el_5_x86_64" }
        'i386': { include "pe_agent::${pe_install_version}::packages::el_5_i386" }
        default: { fail("unsupported platform") }
      }
    }
    default: { fail("unsupported platform") }
  }

  # if install, include the config.pp option to set the puppet.conf and other things
  include pe_agent::config
}
