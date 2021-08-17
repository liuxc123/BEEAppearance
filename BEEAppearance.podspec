Pod::Spec.new do |s|
  s.name             = 'BEEAppearance'
  s.version          = '1.0.0'
  s.summary          = 'A theme programme of BEEAppearance.'
  s.description      = <<-DESC
TODO: 一个主题切换库.
                       DESC
  s.homepage         = 'https://github.com/liuxc123/BEEAppearance'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/BEEAppearance.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'BEEAppearance/Classes/**/*'
  # s.public_header_files = 'BEEAppearance/Classes/BEEAppearance.h'
  s.frameworks = 'UIKit'

  # s.resource_bundles = {
  #   'BEEAppearance' => ['BEEAppearance/Assets/*.png']
  # }
end
