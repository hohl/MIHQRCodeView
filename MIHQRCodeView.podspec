Pod::Spec.new do |s|
  s.name             = "MIHQRCodeView"
  s.version          = "1.0.0"
  s.summary          = "A short description of MIHQRCodeView."
  s.description      = "UIImageView subclass which displays an QR code."
  s.homepage         = "http://github.com/hohl/MIHQRCodeView"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Michael Hohl" => "me@michaelhohl.net" }
  s.source           = { :git => "http://github.com/hohl/MIHQRCodeView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'
end
