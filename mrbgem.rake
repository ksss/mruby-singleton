MRuby::Gem::Specification.new('mruby-singleton') do |spec|
  spec.license = 'MIT'
  spec.author  = 'ksss <co000ri@gmail.com>'

  if File.exist? "#{MRUBY_ROOT}/mrbgems/mruby-metaprog"
    spec.add_test_dependency 'mruby-metaprog', core: 'mruby-metaprog'
  end
end
