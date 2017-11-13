# PTThirdPlatformKit

[![CI Status](http://img.shields.io/travis/flypigrmvb/PTThirdPlatformKit.svg?style=flat)](https://travis-ci.org/flypigrmvb/PTThirdPlatformKit)
[![Version](https://img.shields.io/cocoapods/v/PTThirdPlatformKit.svg?style=flat)](http://cocoapods.org/pods/PTThirdPlatformKit)
[![License](https://img.shields.io/cocoapods/l/PTThirdPlatformKit.svg?style=flat)](http://cocoapods.org/pods/PTThirdPlatformKit)
[![Platform](https://img.shields.io/cocoapods/p/PTThirdPlatformKit.svg?style=flat)](http://cocoapods.org/pods/PTThirdPlatformKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PTThirdPlatformKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PTThirdPlatformKit'
```

### 添加plist配置  

URLTypes  
```ruby
<key>CFBundleURLTypes</key>
<array>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>weixin</string>
<key>CFBundleURLSchemes</key>
<array>
<string>wx78380642630d3e54</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLSchemes</key>
<array>
<string>Prefs</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
<key>CFBundleURLSchemes</key>
<array>
<string>lezhua</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLSchemes</key>
<array>
<string>alipayPlush</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>tencent</string>
<key>CFBundleURLSchemes</key>
<array>
<string>tencent1106408873</string>
</array>
</dict>
<dict>
<key>CFBundleTypeRole</key>
<string>Editor</string>
<key>CFBundleURLName</key>
<string>weibo</string>
<key>CFBundleURLSchemes</key>
<array>
<string>wb1982064134</string>
</array>
</dict>
</array>
```

QueriesSchemes  
```ruby
<key>LSApplicationQueriesSchemes</key>
<array>
<string>wechat</string>
<string>weixin</string>
<string>wx78380642630d3e54</string>
<string>mqqapi</string>
<string>mqq</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqconnect</string>
<string>mqqopensdkdataline</string>
<string>mqqopensdkgrouptribeshare</string>
<string>mqqopensdkfriend</string>
<string>mqqopensdkapi</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqzoneopensdk</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV3</string>
<string>mqzone</string>
<string>mqzonev2</string>
<string>mqzoneshare</string>
<string>wtloginqzone</string>
<string>mqzonewx</string>
<string>mqzoneopensdkapiV2</string>
<string>mqzoneopensdkapi19</string>
<string>mqzoneopensdkapi</string>
<string>mqzoneopensdk</string>
<string>tim</string>
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>sinaweibosso</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
</array>
```


## Author

flypigrmvb, 862709539@qq.com

## License

PTThirdPlatformKit is available under the MIT license. See the LICENSE file for more info.
