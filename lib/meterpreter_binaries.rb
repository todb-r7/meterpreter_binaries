# -*- coding:binary -*-

require 'meterpreter_binaries/version' unless defined? MeterpreterBinaries::VERSION

module MeterpreterBinaries

  EXTENSION_PREFIX      = 'ext_server_'
  METERPRETER_SUBFOLDER = 'meterpreter'

  #
  # Get the path to an extension based on its name (no prefix).
  #
  def self.get_ext(ext_name, binary_suffix)
    return get("#{EXTENSION_PREFIX}#{ext_name}", binary_suffix)
  end

  #
  # Get the path to a meterpretr binary by full name.
  #
  def self.get(name, binary_suffix)
    file_name = "#{name}.#{binary_suffix}".downcase

    # try the data folder first to see if the extension exists, as this
    # allows for the MSF data/meterpreter folder to override what is
    # in the gem. This is very helpful for testing/development without
    # having to move the binaries to the gem folder each time.
    file_path = expand(data_dir, file_name)

    # if not, load it from the local gem folder
    unless ::File.file?(file_path)
      file_path = expand(local_dir, file_name)

      # if it's still not valid, then return nil to indicate
      # that we can't find the extension
      unless ::File.file?(file_path)
        file_path = nil
      end
    end

    return file_path
  end

  #
  # List all the available extensions for the given suffix.
  #
  def self.list_extensions(binary_suffix)
    # Find the valid extensions in the data folder first.
    extensions = enum_ext(data_dir, binary_suffix)

    # merge in any that don't already exist in the gem folder
    enum_ext(local_dir, binary_suffix).each do |e|
      if !extensions.include?(e)
        extensions.push(e)
      end
    end

    return extensions
  end

private

  #
  # Full path to the local gem folder which contains the binaries.
  #
  def self.local_dir
    return ::File.join(::File.dirname(__FILE__), '..', METERPRETER_SUBFOLDER)
  end

  #
  # Full path to the MSF data folder which contains the binaries.
  #
  def self.data_dir
    return ::File.join(Msf::Config.data_directory, METERPRETER_SUBFOLDER)
  end

  #
  # Expand the given root path and file name into a full file location.
  #
  def self.expand(root_dir, file_name)
    return ::File.expand_path(::File.join(root_dir, file_name))
  end

  #
  # Enumerate extensions in the given root folder based on the suffix.
  #
  def self.enum_ext(root_dir, binary_suffix)
    exts = []
    ::Dir.entries(root_dir).each do |f|
      if (::File.file?(::File.join(root_dir, f)) && f =~ /#{EXTENSION_PREFIX}(.*)\.#{binary_suffix}/ )
        exts.push($1)
      end
    end
    return exts
  end

end

