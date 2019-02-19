# SwiftLook

**it's like a QuickLook for Swift files**

> I made this for personal use, but feel free to use it or contribute.

**If you want to:**

- drop a quick look at some code
- read-only (without the extra editor capabilities)
- full-screen

**Then just:**

- start Xcode / New Project / iOS / [Document Based App](https://developer.apple.com/document-based-apps)
- setup dependencies (I used this approach [here](https://www.ralfebert.de/ios-examples/xcode/ios-dependency-management-with-swift-package-manager))
- add [Splash](http://github.com/JohnSundell/Splash) package made by [@JohnSundell](http://twitter.com/JohnSundell)
- connect those two together and voila: you have a nice reading app :)

## Installation

Clone this repo and open it in terminal:

- run `cd Dependencies` to enter [Dependencies](Dependencies) directory
- run `swift package update` to resolve dependencies
- run `rake xcodeproj` to [adapt .xcodeproj file for iOS](https://www.ralfebert.de/ios-examples/xcode/ios-dependency-management-with-swift-package-manager)
- run `xed ..` to open Xcode project

Build and run the app on device!

## License
This code is released under the MIT license. See [LICENSE](LICENSE) for details.
