Pod::Spec.new do |s|
  s.name             = "BIObjCHelpers"
  s.version          = "0.1.0"
  s.summary          = "My collection of Objective-C helpers"
  s.description      = <<-DESC
                       Simple collection of classes commonly used in Objective-C projects.
                       DESC
  s.homepage         = "https://github.com/grigaci/BIObjCHelpers"
  s.license          = 'MIT'
  s.author           = { "Bogdan Iusco" => "bogdan.iusco@gmail.com" }
  s.source           = { :git => "https://github.com/grigaci/BIObjCHelpers.git", :tag => "0.1.0" }
  # s.social_media_url = 'https://twitter.com/bogdaniusco'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'BIObjCHelpersExample/Classes/Helpers/**/*.{h,m}'

  s.public_header_files = 'BIObjCHelpersExample/Classes/Helpers/**/*.h'
end
