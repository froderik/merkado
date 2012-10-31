guard 'rspec' do
  watch( %r{^spec/integration/.+_spec\.rb$}    )
  watch( %r{^spec/model/.+_spec\.rb$}    )
  watch( %r{^spec/helpers/.+\.rb$}             ) { 'spec' }
  watch( %r{^app/assets/javascripts/.+.coffee$}) { 'spec' }
  watch( %r{^app/controllers/.+.rb$}           ) { 'spec' }
  watch( %r{^app/models/(.+).rb$}              ) { |m| "spec/model/#{m[1]}_spec.rb" }
  watch( %r{^app/views/.+/.+.haml$}            ) { 'spec' }
  watch( %r{^config/.+.rb$}                    ) { 'spec' }
  watch( 'spec/spec_helper.rb'                 ) { 'spec' }
  watch( 'Gemfile.lock'                        ) { 'spec' }
end

