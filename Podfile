platform :ios, '12.0'

target 'TestGitHubProj' do
  use_frameworks!

  pod 'SwiftLint'
  pod 'Firebase/Auth'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end
