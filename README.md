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


- [Base]() —— 包含 ViController 基类，以及常用的 Category
- [DLViews]() —— 常用的自定义视图控件
- [Utility]()  ——通用类，例如：错误码解析，定位，键盘管理等

## 详细介绍

#### 通用控件

- [DLTextField]() —— 内容缩进的 UITextField
- [DLTextFieldAttacnment]() —— 包含图标/名称的输入框
- [DLBoxCheckButton]() —— 条款勾选框
- [DLDatePopupView]() —— 时间选择器

#### 登录界面
[!image]() 
[DLLoginViewConfig]() —— 配置登录界面
[DLLoginInputView]() —— 登录界面输入框部分
[DLLoginView]() —— 登录页面

## 更新步骤
1. 修改 `Pods/DLPublic/DLPublic/` 下源文件
2. 编辑 PodSpec 文件，主要是修改版本号 s.version 属性
3. 测试 PodSpec 文件格式是否正确：`pod lib lint`
4. Push to repo
5. 打 tag， tag 值要同版本号一致：`git tag 1.0.x`
6. 更新 PodSpec 文件到仓库：`pod repo push PodSpecs *.podspec`
7. 更新完毕

## License

`DLPublic` is available under the MIT license. See the LICENSE file for more info.
