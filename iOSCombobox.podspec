Pod::Spec.new do |s|
  s.name                  = "iOSCombobox"
  s.version               = "0.0.1"
  s.summary               = "Replicates the <select> tag in Safari for native apps"
  s.homepage              = "https://github.com/jakemwood/iOSCombobox"
  s.license               = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author                = ["Jake Wood"]
  s.source                = { :git => "https://github.com/jakemwood/iOSCombobox.git" }
  s.platform              = :ios
  s.ios.deployment_target = '5.0'
  s.source_files          = '*.{h,m}'
  s.public_header_files   = ['iOSCombobox.h', 'BSKeyboardControls.h']
  s.requires_arc          = true
end
