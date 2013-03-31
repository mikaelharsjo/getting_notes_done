# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'
require 'formotion'
Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Evernote'
  app.frameworks += ['Security']
  app.pods do
    pod 'Evernote-SDK-iOS'
  end
  app.info_plist['CFBundleURLTypes'] = [
    { 
      'CFBundleURLSchemes' => ['en-mikaelharsjo'] }
  ]
end
