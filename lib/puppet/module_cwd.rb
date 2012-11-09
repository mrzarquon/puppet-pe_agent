module Puppet::Parser::Functions
  newfunction(:has_custom_motd, :type => :rvalue) do |args|
    motd_path = File.join(
      Puppet::Module.find('motd', Thread.current[:environment]).file_directory,
      'motd',
    )
    File.exists?(motd_path)
  end
end