#
# Be sure to run `pod lib lint PTThirdPlatformKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PTThirdPlatformKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PTThirdPlatformKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/flypigrmvb/PTThirdPlatformKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'flypigrmvb' => '862709539@qq.com' }
  s.source           = { :git => 'https://github.com/flypigrmvb/PTThirdPlatformKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PTThirdPlatformKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PTThirdPlatformKit' => ['PTThirdPlatformKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'

    # 配置Prefix Header
    s.prefix_header_contents = '#import <PTFoundation/UtilMacro.h>', '#import <PTFoundation/DebugConfig.h>'

    # 配置系统Framework
    s.frameworks = 'CoreMotion'

    # 添加资源文件
    s.resource = 'PTThirdPlatformKit/Frameworks/**/*.bundle'

    # 添加依赖的framework
    s.vendored_frameworks = 'PTThirdPlatformKit/Frameworks/**/*.framework'

    # 添加依赖的Pod库
    s.dependency 'WeiboSDK'
    s.dependency 'WechatOpenSDK'
    s.dependency 'PTFoundation'
    s.dependency 'YYModel'
    s.dependency 'SDWebImage'

    # 添加依赖的系统静态库
    s.libraries = 'xml2', 'z', 'c++', 'stdc++.6', 'sqlite3'


end
