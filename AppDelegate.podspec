Pod::Spec.new do |spec|
  spec.name          = 'AppDelegate'
  spec.version       = '0.1.0'
  spec.license       = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage      = 'https://github.com/jasonnam/AppDelegate'
  spec.authors       = { 'Jason Nam' => 'contact@jasonnam.com' }
  spec.summary       = 'Break down app delegate into smaller and single-purpose plugins.'
  spec.source        = { :git => 'https://github.com/jasonnam/AppDelegate.git', :tag => '0.1.0' }
  spec.swift_version = '5.0'

  spec.ios.deployment_target = '8.0'

  spec.source_files = 'Sources/AppDelegate/*.swift'
end
