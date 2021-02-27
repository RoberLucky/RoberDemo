#
# Be sure to run `pod lib lint MavliOSADSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MavliOSADSDK'
  s.version          = '1.1.1'
  s.summary          = 'A short description of MavliOSADSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                      test adsdkdemo desc
                       DESC

  s.homepage         = 'https://github.com/RoberLucky/RoberDemo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RoberLucky' => 'lyx411326@163.com' }
  s.source           = { :git => 'https://github.com/RoberLucky/RoberDemo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ios_libs/MavliOSADSDK'
  
   s.resource_bundles = {
     'MavliOSADSDK' => ['ios_libs/MavliOSADSDK/Assets/*']
   }
   
   s.subspec 'Aps' do |aa|
   aa.source_files = 'ios_libs/MavliOSADSDK/Classes/Aps/*'
   aa.dependency 'AmazonPublisherServicesMoPubAdapter', '1.2.0'
   aa.dependency 'AmazonPublisherServicesSDK', '3.4.2'
   end
   
   s.subspec 'Mopub-plugin' do |pp|
   pp.source_files = 'ios_libs/MavliOSADSDK/Classes/Mopub-plugin/*'
   end
   
   s.subspec 'Mediation' do |mm|
     mm.subspec 'AppLovin' do |ap|
       ap.source_files = 'ios_libs/MavliOSADSDK/Classes/Mediation/AppLovin/Network/*'
       ap.dependency 'AppLovinSDK', '6.14.9'
     end
     mm.subspec 'FaceBook' do |ff|
       ff.source_files = 'ios_libs/MavliOSADSDK/Classes/Mediation/FaceBook/NetWork/*'
       ff.dependency 'FBAudienceNetwork', '6.2.1'
     end
     mm.subspec 'IronSource' do |ii|
       ii.source_files = 'ios_libs/MavliOSADSDK/Classes/Mediation/IronSource/Network/*'
       ii.dependency 'IronSourceSDK', '7.0.4.0'
     end
     mm.subspec 'AdMob' do |ad|
       ad.source_files = 'ios_libs/MavliOSADSDK/Classes/Mediation/MoPub-AdMob-Adapters/AdMob/*'
       ad.dependency 'Google-Mobile-Ads-SDK', '7.68.0'
     end
   end

  s.public_header_files = 'Pod/ios_libs/MavliOSADSDK/Classes/**/*.h'
  s.frameworks = 'UIKit'
  #s.dependency 'Google-Mobile-Ads-SDK', '7.68.0'
  s.dependency 'FBSDKCoreKit', '~>8.1'
  s.dependency 'Fyber_Marketplace_MoPubAdapter', '7.7.3'
  s.dependency 'Fyber_Marketplace_MoPubAdapter', '7.7.3'
  s.dependency 'MoPub-Chartboost-Adapters', '8.3.1.1'
  s.dependency 'mopub-ios-sdk', '5.14.1'
  s.dependency 'MoPub-UnityAds-Adapters', '3.5.1.0'
  s.dependency 'MoPub-Vungle-Adapters', '6.8.1.0'
  s.dependency 'PureLayout'
  s.dependency 'smaato-ios-sdk-mediation-mopub' ,'5.14.1.0'
end
