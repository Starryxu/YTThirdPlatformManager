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
    s.default_subspec = 'Core'

    s.subspec 'Core' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/Classes/**/*'
        # 配置系统Framework
        subspec.frameworks = 'CoreMotion'
        subspec.dependency 'SDWebImage'
        # 添加依赖的系统静态库
        subspec.libraries = 'xml2', 'z', 'c++', 'stdc++.6', 'sqlite3'
    end


    s.subspec 'AlipayManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/AlipayManager/**/*'
        # 添加资源文件
        subspec.resource = 'PTThirdPlatformKit/AlipayManager/**/*.bundle'
        # 添加依赖的framework
        subspec.vendored_frameworks = 'PTThirdPlatformKit/AlipayManager/**/*.framework'
        subspec.frameworks = 'CoreTelephony', 'SystemConfiguration'
        subspec.dependency 'PTThirdPlatformKit/Core'
    end


    s.subspec 'TencentManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/TencentManager/**/*'
        # 添加资源文件
        subspec.resource = 'PTThirdPlatformKit/TencentManager/**/*.bundle'
        # 添加依赖的framework
        subspec.vendored_frameworks = 'PTThirdPlatformKit/TencentManager/**/*.framework'
        subspec.frameworks = 'SystemConfiguration'
        subspec.dependency 'PTThirdPlatformKit/Core'
    end


    s.subspec 'WeiboManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/WeiboManager/**/*'
        subspec.dependency 'WeiboSDK'
        subspec.dependency 'PTThirdPlatformKit/Core'
    end

    s.subspec 'WXManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/WXManager/**/*'
        subspec.dependency 'WechatOpenSDK'
        subspec.dependency 'PTThirdPlatformKit/Core'
    end

end
