Pod::Spec.new do |s|
  s.name         = "NsUpdateScreenModule"
  s.version      = "0.1.0"
  s.summary      = "Pantalla para actualizar la app "
  s.homepage     = "https://github.com/MariaC15/NsUpdateScreenModuleiOS"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = "Wuilmer Medrano"
  s.source       = { :git => "https://github.com/MariaC15/NsUpdateScreenModuleiOS.git", :tag => s.version.to_s }
  s.frameworks   = 'UIKit'
  s.requires_arc = true
  s.source_files = 'Sources/NsUpdateScreenModule/*.swift'
  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  s.swift_version = '5.0'
end
