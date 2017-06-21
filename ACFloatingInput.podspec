#
# Be sure to run `pod lib lint ACFloatingInput.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ACFloatingInput'
  s.version          = '1.0.9'
  s.summary          = 'Floating input control.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/mietelski-robert/ACFloatingInput'
  s.screenshots     = 'https://raw.githubusercontent.com/mietelski-robert/ACFloatingInput/master/Screens/screenshots_1.png', 'https://raw.githubusercontent.com/mietelski-robert/ACFloatingInput/master/Screens/screenshots_2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mietelski-robert' => 'mietelski.robert@gmail.com' }
  s.source           = { :git => 'https://github.com/mietelski-robert/ACFloatingInput.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ACFloatingInput/Source/**/*'
  
  s.resource_bundles = {
    'ACFloatingInput' => ['ACFloatingInput/Resources/*.png']
  }

  # s.public_header_files = 'Pod/Source/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
