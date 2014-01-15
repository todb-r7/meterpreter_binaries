# Meterpreter Binaries

This gem is a Metasploit-specific gem that contains all of the
compiled binaries for the Meterpreter payload. This is made up of:

* Windows DLLs
* POSIX LSOs
* POSIX BIN

The other files have been left alone for now.

## Installation

Given the nature of the contents of this gem, installation
outside of Metasploit is not advised. To use Meterpreter,
download and install Metasploit itself.

## Building

To build the gem:

1. Open `meterpreter_binaries.gemspec` and change the `spec.version`
  value to the appropriate number.
1. Copy the updated binaries into the `data/meterpreter` folder.
1. Run `rake build` to generate the new gem file.
1. Run `rake release` to release the binary to RubyGems.
