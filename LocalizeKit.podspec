Pod::Spec.new do |s|
  s.name         = "LocalizeKit"
  s.version      = "0.5.0"
  s.summary      = "Localization library."
  s.homepage     = "http://voucherry.com"
  s.license      = 'MIT'
  s.author       = { "Cristian Bica" => "cristian.bica@gmail.com" }
  s.source       = { :git => "https://github.com/voucherry/LocalizeKit.git", :tag => "0.9.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'LocalizeKit/*.{h,m}'
  s.requires_arc = true
  s.dependency  'ObjcAssociatedObjectHelpers'
  s.dependency  'JSONKit'
  s.dependency  'RegexKitLite'
end
