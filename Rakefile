# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'
require 'bubble-wrap'
require 'formotion'
require 'teacup'
Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.fonts = ['Inconsolata.ttf', 'one_stroke_script.ttf', 'Delius-Regular.ttf', 'PermanentMarker.ttf'] 
  app.name = 'Getting Notes Done'
  app.icons = ['images/icon_iphone.png', 'images/icon_iphone_retina.png']
  app.prerendered_icon = true
  app.frameworks += ['Security', 'QuartzCore']
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
