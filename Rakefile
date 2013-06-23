# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'motion-cocoapods'
require 'bubble-wrap'
require 'formotion'
Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.fonts = ['fonts/Inconsolata.ttf', 'fonts/one_stroke_script.ttf', 'fonts/Delius-Regular.ttf', 'fonts/PermanentMarker.ttf'] 
  app.name = 'Getting Notes Done'
  app.icons = ['images/icon_iphone.png', 'images/icon_iphone_retina.png']
  app.prerendered_icon = true
  app.frameworks += ['Security', 'StoreKit']
  app.codesign_certificate = 'iPhone Distribution: Mikael Harsjo'
  app.identifier = 'com.mikaelharsjo.gnd*'
  app.provisioning_profile = '/Users/mikaelharsjo/Library/MobileDevice/Provisioning Profiles/A9C3C9D1-6BBD-448A-A0B1-167253F0DC84.mobileprovision'
  app.pods do
    pod 'Evernote-SDK-iOS'
  end
  app.info_plist['CFBundleURLTypes'] = [
    { 
      'CFBundleURLSchemes' => ['en-mikaelharsjo'] }
  ]
end
#require 'bundler'
#Bundler.require(:default)
