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
  app.name = 'Evernote'
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
