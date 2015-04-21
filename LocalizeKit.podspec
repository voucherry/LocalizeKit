Pod::Spec.new do |s|
  s.name         = "LocalizeKit"
  s.version      = "0.9.0"
  s.summary      = "iOS Localization library."
  s.description  = <<-DESC
                     iOS Localization library. Pluralization support. Supports remote adjusting translations.
                     DESC
  s.homepage     = "http://inpact.care"
  s.license      = "MIT"
  s.author       = { "Cristian Bica" => "cristian.bica@gmail.com" }
  s.source       = { :git => "https://github.com/voucherry/LocalizeKit.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #   'LocalizeKit' => ['Pod/Assets/*.png']
  # }
  s.frameworks = 'UIKit'
  s.dependency 'RegExCategories', '~> 1.0'
end

