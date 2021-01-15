# DefinitionAdvertising

[![CI Status](https://img.shields.io/travis/Admin/DefinitionAdvertising.svg?style=flat)](https://travis-ci.org/Admin/DefinitionAdvertising)
[![Version](https://img.shields.io/cocoapods/v/DefinitionAdvertising.svg?style=flat)](https://cocoapods.org/pods/DefinitionAdvertising)
[![License](https://img.shields.io/cocoapods/l/DefinitionAdvertising.svg?style=flat)](https://cocoapods.org/pods/DefinitionAdvertising)
[![Platform](https://img.shields.io/cocoapods/p/DefinitionAdvertising.svg?style=flat)](https://cocoapods.org/pods/DefinitionAdvertising)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage
In didFinishLaunchingWithOptions method:
```swift
DefinitionAdvertising.shared.delegate = self
DefinitionAdvertising.shared.configuration(appToken: API_KEY, url: "Here select URL from Enum or enter your")

public struct Urls: DefinitionRawRepresentable {
        
    public var rawValue: String
        
    public static let chksource = Urls(rawValue: "https://chksource.com")
    public static let chkmob = Urls(rawValue: "https://check.chkmob.com")
    public static let bittiu = Urls(rawValue: "https://check.bittiu.com")
    public static let trklabs = Urls(rawValue: "https://check.trklabs.com")
    public static let devpng = Urls(rawValue: "https://check.devpng.com")
    public static let pingfront = Urls(rawValue: "https://check.pingfront.com")
}
```

## Installation

DefinitionAdvertising is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DefinitionAdvertising', :git => 'https://github.com/LebedAlexander/DefinitionAdvertising'
```

## Author
Lebed Alexander, revilosiz@gmail.com

## License

DefinitionAdvertising is available under the MIT license. See the LICENSE file for more info.
