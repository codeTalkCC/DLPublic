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
  s.version          = '1.2.1'	
  s.summary          = '为了更好的开发与代码复用,把大多数项目经常用到的功能与文件整理进了DLPublic'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
为了更好的开发与代码复用,把大多数项目经常用到的功能与文件整理进了DLPublic
功能介绍:分类集合 与 功能集合
                       DESC

  s.homepage         = 'https://github.com/codeTalkCC/DLPublic.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xfjiang' => 'xfjiang@idelan.cn' }
  s.source           = { :git => 'https://github.com/codeTalkCC/DLPublic.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

 s.source_files = 'DLPublic/**/*.{h,m}'

#s.subspec 'Utility' do |utility|
#   utility.source_files = 'AFNetworking/AFSecurityPolicy.{h,m}'
#   utility.public_header_files = 'AFNetworking/AFSecurityPolicy.h'
#   utility.frameworks = 'Foundation'
#end

  s.resource_bundles = {
     'DLPublic' => ['DLPublic/Assets/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'CoreLocation', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
