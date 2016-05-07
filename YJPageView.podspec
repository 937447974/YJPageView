#
#  Be sure to run `pod spec lint NAME.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

# 注册pod权限：pod trunk register 937447974@qq.com '阳君' --description='china beijing'
# 验证podspec命令：pod spec lint或 pod spec lint --allow-warnings
# pod发包：pod trunk push YJPageView.podspec --allow-warnings

Pod::Spec.new do |s|

    # ――― Root specification
    s.name     = "YJPageView"
    s.version  = "1.1.0"
    s.author   = { "阳君" => "937447974@qq.com" }
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.homepage = "https://github.com/937447974/YJPageView"
    s.source = { :git => "https://github.com/937447974/YJPageView.git", :tag => "v#{s.version}" }
    s.summary  = "轮播图、导航图、小说翻页等多种翻页模式封装"

    # ――― Platform
    s.platform = :ios
    s.ios.deployment_target = "6.0"

    # ――― Build settings
    s.frameworks = "UIKit", "Foundation"
    s.prefix_header_file = 'Prefix/YJPageView-Prefix.pch'
    s.requires_arc = true

    # ——— Subspecs
    s.default_subspec = 'ImagePage'
    s.subspec 'Core' do |core|
        core.source_files = 'Classes/Core/*.{h,m}'
        core.dependency 'YJAutoLayout'
    end
    s.subspec 'ImagePage' do |ip|
        ip.source_files = 'Classes/ImagePage/*.{h,m,xib}'
        ip.dependency 'YJPageView/Core'
    end

end
