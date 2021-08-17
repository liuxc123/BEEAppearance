Pod::Spec.new do |s|
    
  s.name             = 'BEEAppearance'
  s.version          = '1.0.0'
  s.summary          = '一个简单易用的主题库'
  
  s.homepage         = 'https://github.com/liuxc123/BEEAppearance'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  
  s.source           = { :git => 'https://github.com/liuxc123/BEEAppearance.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'

  s.source_files = 'BEEAppearance/Classes/**/*'
  
  s.frameworks = 'UIKit'

  s.requires_arc = true
  
end
