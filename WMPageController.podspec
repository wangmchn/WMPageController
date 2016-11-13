Pod::Spec.new do |s|
   s.name         = "WMPageController"
<<<<<<< 6ac28d29c29356bba61207566c26163b94c1c84e
   s.version      = "2.0.2"
=======
   s.version      = "2.1.0"
>>>>>>> Fix a bug: `selectIndex` didn't work sometimes.
   s.summary      = "An easy solution to page controllers like NetEase News"
   s.homepage     = "https://github.com/wangmchn/WMPageController"
   s.license      = 'MIT (LICENSE)'
   s.author       = { "wangmchn" => "wangmchn@163.com" }
<<<<<<< 6ac28d29c29356bba61207566c26163b94c1c84e
   s.source       = { :git => "https://github.com/wangmchn/WMPageController.git", :tag => "2.0.2" }
=======
   s.source       = { :git => "https://github.com/wangmchn/WMPageController.git", :tag => "2.1.0" }
>>>>>>> Fix a bug: `selectIndex` didn't work sometimes.
   s.platform     = :ios, '6.0'

   s.source_files = 'WMPageController', 'WMPageController/**/*.{h,m}'
   s.exclude_files = 'WMPageControllerDemo'

   s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
   s.requires_arc = true
 end