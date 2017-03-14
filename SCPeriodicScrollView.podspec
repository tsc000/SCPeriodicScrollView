

Pod::Spec.new do |s|

  s.name         = 'SCPeriodicScrollView'
  s.version      = '0.0.1'
  s.summary      = 'A fast, lightweight carousel figure.'
  s.description  = 'A fast, lightweight carousel figure, which is based on UICollectionView.'
  s.homepage     = 'https://github.com/tsc000/SCPeriodicScrollView'
  s.license      = 'MIT'
  s.author             = { 'tsc000' => '787753577@qq.com' }
  s.platform     = 'ios'
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/tsc000/SCPeriodicScrollView.git', :tag => s.version }
  s.source_files  = 'SCPeriodicScrollView/Source/*.{h,m}'
  s.framework  = 'UIKit'
  s.requires_arc = true
  s.dependency "SDWebImage"
end
