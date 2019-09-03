# DMActionController

[![Version](https://img.shields.io/cocoapods/v/DMParallaxHeader.svg?style=flat)](http://cocoapods.org/pods/DMActionController)
![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Platform](https://img.shields.io/cocoapods/p/DMParallaxHeader.svg?style=flat)](http://cocoapods.org/pods/DMActionController)
[![License](https://img.shields.io/cocoapods/l/DMParallaxHeader.svg?style=flat)](http://opensource.org/licenses/MIT)

DMActionController is customizable action sheet with an api that is base on UIKit's UIAlertController.

Table Style | Collection Style
------------ | -------------
![Table1](/Screenshots/screenshot-2.png) | ![Collection1](/Screenshots/screenshot-1.png)
![Table2](/Screenshots/screenshot-4.png) | ![Collection2](/Screenshots/screenshot-5.png)

## Usage

If you want to try it, simply run:

```
pod try DMActionController
```

+ Presenting an action controller is straightforward, e.g:

```swift
let actionSheet = DMActionController(title: "My Action Sheet", message: "This is an action sheet.", preferredStyle: .table)
actionSheet.addAction(DMAction(title: "Do Action", style: .default, handler: { _ in
     NSLog("The user tapped \"Do Action\" in the action sheet.")
}))
self.present(actionSheet, animated: true, completion: nil)
```

## Installation

DMActionController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DMActionController'
```

## License

DMActionController is available under the MIT license. See the LICENSE file for more info.
