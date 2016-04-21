Pod::Spec.new do |s|
  s.name             = 'MarkedView'
  s.version          = '0.1.0'
  s.summary          = 'The Markdown text web viewer.'
  s.homepage         = 'https://github.com/mittsuu/MarkedView-for-iOS'
  s.license          = 'MIT'
  s.author           = { 'mittsu' => 'mittsu553@gmail.com' }
  s.source           = { :git => 'https://github.com/mittsuu/MarkedView-for-iOS.git', :tag => 'v0.1.0' }
  s.platform     = :ios, '8.3'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MarkedView' => ['Pod/Assets/**/*']
  }

end
