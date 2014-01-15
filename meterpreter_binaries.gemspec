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
                        Meterpreter function. This includes binaries for Windows, POSIX
                        and Java.}
  spec.homepage      = "http://www.metasploit.com"
  spec.license       = '3-clause (or "modified") BSD'

  spec.files         = `git ls-files`.split("\n")
  spec.files        += Dir['data/meterpreter/*']
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
