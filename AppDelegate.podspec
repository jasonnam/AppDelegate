Pod::Spec.new do |spec|
  spec.name          = 'AppDelegate'
  spec.version       = '0.1.1'
  spec.license       = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage      = 'https://github.com/jasonnam/AppDelegate'
  spec.authors       = { 'Jason Nam' => 'contact@jasonnam.com' }
  spec.summary       = 'Break down app delegate into smaller and single-purpose plugins.'
  spec.source        = { :git => 'https://github.com/jasonnam/AppDelegate.git', :branch => 'develop' }
  spec.swift_version = '5.0'

  spec.ios.deployment_target = '8.0'

  source_files = 'Sources/AppDelegate/*.swift'

  spec.source_files = source_files

  spec.subspec 'RemoteNotification' do |subspec|
    subspec.source_files = source_files
    subspec.pod_target_xcconfig = {
      'OTHER_SWIFT_FLAGS' => '-DREMOTE_NOTIFICATION'
    }
  end
  spec.subspec 'Fetch' do |subspec|
    subspec.source_files = source_files
    subspec.pod_target_xcconfig = {
      'OTHER_SWIFT_FLAGS' => '-DFETCH'
    }
  end
  spec.subspec 'ApplicationState' do |subspec|
    subspec.source_files = source_files
    subspec.pod_target_xcconfig = {
      'OTHER_SWIFT_FLAGS' => '-DAPPLICATION_STATE'
    }
  end
  spec.subspec 'Scene' do |subspec|
    subspec.source_files = source_files
    subspec.pod_target_xcconfig = {
      'OTHER_SWIFT_FLAGS' => '-DSCENE'
    }
  end
end
