# AppDelegate

[![CocoaPods](https://img.shields.io/cocoapods/v/AppDelegate.svg)](https://cocoapods.org/pods/AppDelegate)

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
