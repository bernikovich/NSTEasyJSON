Pod::Spec.new do |spec|
  spec.name         = 'NSTEasyJSON'
  spec.version      = '1.0.5'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/bernikowich/NSTEasyJSON'
  spec.authors      = { 'Timur Bernikovich' => 'bernikowich@icloud.com' }
  spec.summary      = 'Typesafe collection usage.'
  spec.source       = { :git => 'https://github.com/bernikowich/NSTEasyJSON.git', :tag => spec.version }
  spec.source_files = 'NSTEasyJSON/Classes/NSTEasyJSON.{h,m}'
  spec.module_name  = 'NSTEasyJSON'
end
