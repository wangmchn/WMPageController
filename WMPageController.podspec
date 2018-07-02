Pod::Spec.new do |s|
   s.name         = "WMPageController"
   s.version      = "2.5.2"
   s.summary      = "An easy solution to page controllers like NetEase News"
   s.homepage     = "https://github.com/wangmchn/WMPageController"
   s.license      = 'MIT (LICENSE)'
   s.author       = { "wangmchn" => "wangmchn@163.com" }
   s.source       = { :git => "https://github.com/wangmchn/WMPageController.git", :tag => s.version.to_s }
   s.ios.deployment_target = '6.0'

   s.source_files = 'WMPageController/', 'WMPageController/**/*.{h,m}'

   s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
   s.requires_arc = true
 end