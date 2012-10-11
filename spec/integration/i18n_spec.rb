require 'yaml'

def traverse_hash actual, expected
  actual.class.should == expected.class
  if actual.is_a? Hash
    actual.keys.should =~ expected.keys
    actual.all? do |k,v|
      traverse_hash v, expected[k]
    end
  else
    true
  end
end

def compare_files one_file, other_file
  one_lang   = lang_from one_file
  other_lang = lang_from other_file
  one_hash   = YAML.load_file( one_file   )[one_lang]
  other_hash = YAML.load_file( other_file )[other_lang]

  traverse_hash one_hash, other_hash
  traverse_hash other_hash, one_hash
end

def lang_from file_name
  file_name.split('/')[2].split('.')[0]
end

describe 'internationalization' do
  it 'matches all the keys' do
    compare_files 'config/locales/en.yml', 'config/locales/sv.yml'
  end
end
