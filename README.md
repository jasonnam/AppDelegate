# AppDelegate

[![GitHub release](https://img.shields.io/github/release/jasonnam/AppDelegate.svg)](https://github.com/jasonnam/AppDelegate/releases)
[![CocoaPods](https://img.shields.io/cocoapods/v/AppDelegate.svg)](https://cocoapods.org/pods/AppDelegate)
[![travis-ci build status](https://travis-ci.com/jasonnam/AppDelegate.svg?branch=master)](https://travis-ci.com/jasonnam/AppDelegate)

Break down app delegate into smaller and single-purpose plugins.

## Installation

### CocoaPods

```ruby
pod 'AppDelegate'
```

## Usage

```swift
import UIKit

@UIApplicationMain
final class AppDelegateMain: AppDelegate {

    override init() {
        super.init()
        plugins = [
            AppDelegateLog(),
            AppDelegateFacebookSDK(),
            AppDelegateUniversalLink(),
            AppDelegatePushNotification()
        ]
    }
}
```

## License

AppDelegate is released under the MIT license. [See LICENSE](https://github.com/jasonnam/AppDelegate/blob/master/LICENSE) for details.
