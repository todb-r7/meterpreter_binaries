# encoding: UTF-8

require 'meterpreter_binaries/version' unless defined? MeterpreterBinaries::VERSION

module MeterpreterBinaries

  EXTENSION_PREFIX      = 'ext_server_'
  METERPRETER_SUBFOLDER = 'meterpreter'

  def self.get_ext(ext_name, binary_suffix)
    return get("#{EXTENSION_PREFIX}#{ext_name}", binary_suffix)
  end

  def self.get(name, binary_suffix)
    file_name = "#{name}.#{binary_suffix}".downcase

    # try the local folder first to see if the extension exists
    file_path = expand(local_dir, file_name)

    # if not, load it from the data folder as that's where the
    # rest of the meterpreter stuff lives
    unless ::File.file?(file_path)
      file_path = expand(data_dir, file_name)

      # if it's still not valid, then return nil to indicate
      # that we can't find the extension
      unless ::File.file?(file_path)
        file_path = nil
      end
    end

    return file_path
  end

  def self.list_extensions(binary_suffix)
    # we shouldn't ever have the same files in two different
    # locations, so it should be save to enumerate both and
    # return a collection of the two combined
    local = enum_ext(local_dir, binary_suffix)
    data = enum_ext(data_dir, binary_suffix)
    local + data
  end

private

  def self.local_dir
    return ::File.join(::File.dirname(__FILE__), '..', METERPRETER_SUBFOLDER)
  end

  def self.data_dir
    return ::File.join(Msf::Config.data_directory, METERPRETER_SUBFOLDER)
  end

  def self.expand(root_dir, file_name)
    return ::File.expand_path(::File.join(root_dir, file_name))
  end

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

