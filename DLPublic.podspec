#
# Be sure to run `pod lib lint DLPublic.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
# pod lib lint DLPublic.podspec
# pod repo push PodSpecs DLPublic.podspec

Pod::Spec.new do |s|
  s.name             = 'DLPublic'
  s.version          = '1.0.2'
  s.summary          = 'DLPublic is common components used for routine.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This pulic contains iOS components used for routine.
                       DESC

  s.homepage         = 'http://192.168.30.20:3020/xfjiang/DLPublic'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xfjiang' => 'xfjiang@idelan.cn' }
  s.source           = { :git => 'http://192.168.30.20:3020/xfjiang/DLPublic.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'DLPublic/Base/**/*', 'DLPublic/Utility/**/*', 'DLPublic/**'
  
  s.resource_bundles = {
     'DLPublic' => ['DLPublic/Assets/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'CoreLocation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
