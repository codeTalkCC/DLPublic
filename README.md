# DLPublic

[![License](https://img.shields.io/cocoapods/l/DLPublic.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYWebImage/master/LICENSE)&nbsp;
[![Version](https://img.shields.io/cocoapods/v/DLPublic.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

DLPublic is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DLPublic", :git => 'http://192.168.30.20:3020/xfjiang/DLPublic.git'
```
e.g.

```ruby
source 'http://192.168.30.20:3020/xfjiang/DLPublic'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'
def pods
pod 'DLPublic', :git => 'http://192.168.30.20:3020/xfjiang/DLPublic.git'
pod 'MBProgressHUD'
end

target '__YOUR_PROJECT_NAME__' do
pods
end
```

## DLPublic

`DLPublic.h`: Header

#### Base

*DLPublicMacro.h:* Common Macro File

*Class:* Base Class

*Foundation:* Foundation Category

*UIKit:* UIKit Category

#### Utility

`DLErrorParser`: 错误码解析类

`DLKeyboardManager`: 键盘管理

`DLLocationManager`: 定位管理

## License

`DLPublic` is available under the MIT license. See the LICENSE file for more info.
