# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'meterpreter_binaries/version'

Gem::Specification.new do |spec|
  spec.name          = "meterpreter_binaries"
  spec.version       = MeterpreterBinaries::VERSION
  spec.authors       = ["Rapid7"]
  spec.email         = ["info@rapid7.com"]
  spec.description   = %q{Compiled binaries for Metasploit's Meterpreter}
  spec.summary       = %q{This gem contains all the compiled binaries required to make
                        Meterpreter function. This includes Windows and POSIX binaries.}
  spec.homepage      = "http://www.metasploit.com"
  spec.license       = '3-clause (or "modified") BSD'

  spec.files         = `git ls-files`.split("\n")
  spec.files        += Dir['meterpreter/*']
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.metadata                            = {}
  spec.metadata['meterpreter_commit']      = '4b468c1403190f19db8b0d6d03f83a2b87247947'
  spec.metadata['prev_meterpreter_commit'] = '69b15e87e9cc604071317aa1df21562306f2111c'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
