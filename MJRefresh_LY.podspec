#
# Be sure to run `pod lib lint MJRefresh_LY.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MJRefresh_LY'
  s.version          = '1.1.0'
  s.summary          = 'MJRefresh的封装，将常用的功能以协议的方式封装。通过遵循相关的协议，可以实现快速添加上拉下拉功能，不用再重复去处理逻辑。'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/ButtFly/MJRefresh_LY'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ButtFly' => '315585758@qq.com' }
  s.source           = { :git => 'https://github.com/ButtFly/MJRefresh_LY.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  
  s.source_files = 'MJRefresh_LY/Classes/**/*'
  
  s.dependency 'MJRefresh'
end
