guard 'rspec', :version => 2 do
  watch( %r{^spec/integration/.+_spec\.rb$} )
  watch( %r{^spec/helpers/.+\.rb$}          ) { "spec" }
  watch( %r{^app/controllers/.+.rb$}        ) { "spec" }
  watch( %r{^app/models/.+.rb$}             ) { "spec" }
  watch( %r{^app/views/.+/.+.haml$}         ) { "spec" }
  watch( %r{^config/.+.rb$}                 ) { "spec" }
  watch( 'spec/spec_helper.rb'              ) { "spec" }
end

