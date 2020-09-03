Pod::Spec.new do |s|
    s.name = 'CMRuby'
    s.version = '2.1.2+0.1.0'
    s.license = { :type => 'MIT', :file => 'CMRuby.xcframework/LEGAL' }
    s.homepage = 'https://github.com/cinderella-project/MRuby-framework'
    s.authors = 'rinsuki', 'mruby contributors'
    s.summary = 'MRuby C Library'
    s.source  = { :http => "https://github.com/cinderella-project/MRuby-framework/releases/download/#{s.version}/CMRuby.xcframework.zip" }
    s.vendored_frameworks = 'CMRuby.xcframework'
    s.ios.deployment_target = "13.0"
    s.osx.deployment_target = "10.15"
end