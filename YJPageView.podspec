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

    # ―――  Spec Metadata
    s.name     = "YJPageView"
    s.version  = "0.9"
    s.summary  = "轮播图、导航图、小说翻页等多种翻页模式封装"
    s.homepage = "https://github.com/937447974/YJPageView"

    # ―――  Spec License
    s.license  = { :type => "MIT", :file => "LICENSE" }

    # ――― Author Metadata
    s.author   = { "阳君" => "937447974@qq.com" }

    # ――― Platform Specifics
    s.platform = :ios
    s.ios.deployment_target = "6.0"

    # ――― Source Location
    s.source = { :git => "https://github.com/937447974/YJPageView.git", :tag => "v#{s.version}" }

    # ――― Source Code
    s.source_files  = "Classes/*.{h,m}", "README.md"

    # ――― Project Linking
    s.frameworks = "UIKit", "Foundation"
    s.vendored_frameworks = 'YJAutoLayout', 'YJTableViewFactory/Utils'
    s.prefix_header_file = 'YJPageView/YJPageView/Prefix/YJPageView-Prefix.h'

    # ――― Project Settings
    s.requires_arc = true

end
