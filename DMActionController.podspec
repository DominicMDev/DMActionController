Pod::Spec.new do |s|
  s.name             = 'DMActionController'
  s.version          = '1.0.1'
  s.swift_version    = '5.0'
  s.summary          = 'A customizable action sheet.'
  s.description      = <<-DESC
                        DMActionController is customizable action sheet with an api that is base on UIKit's UIAlertController.
                       DESC

  s.homepage         = 'https://github.com/dominicmdev/DMActionController'
  s.license          = 'MIT'
  s.authors          = { "Dominic Miller" => "dominicmdev@gmail.com" }
  s.source           = { :git => "https://github.com/dominicmdev/DMActionController.git", :tag => s.version.to_s }

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = 'DMActionController/*.{swift,h,m}'
  s.resources = 'DMActionController/*.{xcassets,xib}'

end
