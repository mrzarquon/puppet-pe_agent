class pe_agent::yum {
  
  $perepo = "http://bender.sneezingdog.com/"
  
  yumrepo { "puppetenterprise":
    baseurl  => "${perepo}/el-\$releasever-\$basearch",
    descr    => "Puppet Enterprises EL Packages",
    enabled  => 1,
    gpgcheck => 0,
  }
}
