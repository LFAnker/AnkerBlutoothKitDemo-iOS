#
#  Be sure to run `pod spec lint AnkerBluetoothKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = 'AnkerBluetoothKit'
  spec.version      = '1.0'
  spec.summary      = 'AnkerBluetoothKit is a SDK for Bluetooth.'
  spec.description  = <<-DESC   
  AnkerBluetoothKit is a SDK for Bluetooth.
                       DESC
  spec.homepage     = 'https://www.lefu.cc/'
  spec.source       = { :git => '' }
  spec.author       = 'Peng'
  spec.requires_arc = true
  spec.platform     = :ios, '9.0'

  spec.ios.vendored_frameworks = 'AnkerBluetoothKit.xcframework'

end
