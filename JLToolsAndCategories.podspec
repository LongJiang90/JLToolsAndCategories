#
# Be sure to run `pod lib lint JLToolsAndCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name         = "JLToolsAndCategories"
  s.version      = "0.0.1"
  s.ios.deployment_target = '9.0'
  s.summary      = "开发中常常用到的工具类以及Category集合。"
  s.description  = "NSString —— 字符串常用操作及验证等； UIImage —— 图片缩放、裁剪操作等； NSDate —— 时间格式转换，年月日获取，当前月的周数等； UIColor —— 根据HEX字符串得到颜色； UIView —— View的Nib加载，焦点坐标获取，SubViews和SupureViews检索； UILabel —— label的行间距设置； JLTools —— 包含常用方法，如：正则判断手机号、邮箱，MD5加密，路径缓存等。"
  s.homepage     = "https://github.com/LongJiangSB/JLToolsAndCategories"
  s.license      = { :type => "MIT", :file => 'LICENSE' }
  s.author       = { "Long Jiang" => "983220205@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/LongJiangSB/JLToolsAndCategories.git", :tag => s.version}
  s.requires_arc = true
  s.frameworks   = 'UIKit','Foundation'
  s.source_files = 'JLToolsAndCategories/Classes/**/*.{h,m}'
  s.public_header_files = 'JLToolsAndCategories/Classes/JLToolsAndCategories.h'

  s.subspec 'Categories' do |ss|
    ss.source_files = 'JLToolsAndCategories/Classes/Categories/*.{h,m}'
    ss.public_header_files = 'JLToolsAndCategories/Classes/Categories/CategoriesH.h'
    ss.frameworks = 'UIKit', 'Foundation', 'QuartzCore'
  end

  s.subspec 'JLTools' do |ss|
    ss.source_files = 'JLToolsAndCategories/Classes/JLTools/*.{h,m}'
    ss.public_header_files = 'JLToolsAndCategories/Classes/JLTools/JLTools.h'
    ss.frameworks = 'UIKit', 'Foundation', 'AudioToolbox', 'AVFoundation', 'Accelerate', 'CoreText'
  end


end
