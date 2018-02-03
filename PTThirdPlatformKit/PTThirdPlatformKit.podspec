
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
    # 设置默认的模块，如果在pod文件中导入pod项目没有指定子模块，导入的是这里指定的模块
    s.default_subspec = 'Core'

    # 定义一个核心模块，用户存放抽象的接口、基类以及一些公用的工具类和头文件
    s.subspec 'Core' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/Classes/**/*'
        # 配置系统Framework
        subspec.frameworks = 'CoreMotion'
        subspec.dependency 'SDWebImage'
        # 添加依赖的系统静态库
        subspec.libraries = 'xml2', 'z', 'c++', 'stdc++.6', 'sqlite3'
    end


    # 支付宝模块
    s.subspec 'AlipayManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/AlipayManager/**/*'
        # 添加资源文件
        subspec.resource = 'PTThirdPlatformKit/AlipayManager/**/*.bundle'
        # 添加依赖第三方的framework
        subspec.vendored_frameworks = 'PTThirdPlatformKit/AlipayManager/**/*.framework'
        # 添加依赖系统的framework
        subspec.frameworks = 'CoreTelephony', 'SystemConfiguration'
        # 依赖的核心模块
        subspec.dependency 'PTThirdPlatformKit/Core'
    end


    # QQ模块
    s.subspec 'TencentManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/TencentManager/**/*'
        # 添加资源文件
        subspec.resource = 'PTThirdPlatformKit/TencentManager/**/*.bundle'
        # 添加依赖第三方的framework
        subspec.vendored_frameworks = 'PTThirdPlatformKit/TencentManager/**/*.framework'
        # 添加依赖系统的framework
        subspec.frameworks = 'SystemConfiguration'
        # 依赖的核心模块
        subspec.dependency 'PTThirdPlatformKit/Core'
    end


    # 微博模块
    s.subspec 'WeiboManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/WeiboManager/**/*'
        # 依赖的微博pod库
        subspec.dependency 'WeiboSDK'
        subspec.dependency 'PTThirdPlatformKit/Core'
    end


    # 微信模块
    s.subspec 'WXManager' do |subspec|
        # 源代码
        subspec.source_files = 'PTThirdPlatformKit/WXManager/**/*'
        # 依赖的微信pod库
        subspec.dependency 'WechatOpenSDK'
        subspec.dependency 'PTThirdPlatformKit/Core'
    end

end
