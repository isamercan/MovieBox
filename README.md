# MovieBox
[![Platform](https://img.shields.io/cocoapods/p/DLAutoSlidePageViewController.svg?style=flat)]()  [![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://developer.apple.com/swift/)

Movies app written in Swift 5 using the TMDb API and demonstrating Clean Architecture, Dependency Injection, MVVM and Coordinators.

## Screenshots

<img src="Screenshots/Home.png" width=200 height=433> <img src="Screenshots/Detail.png" width=200 height=433> <img src="Screenshots/Reviews.png" width=200 height=433>


## How to run

### Requirements

1. Xcode 14.0+
2. Fastlane 2.1.0+ (only needed if you want to run the unit tests and swift lint scans via the CLI).

### Getting started

1. Clone this repository.
2. Via the CLI, go to the root folder of the project where Podfile is located and run `pod install`.
3. Open the workspace file and you are ready to go.


## Third-party libraries
### Alamofire (https://github.com/Alamofire/Alamofire)
Alamofire provides an elegant and composable interface to HTTP network requests. It does not implement its own HTTP networking functionality.
### Kingfisher (https://github.com/onevcat/Kingfisher)
Used for downloading and caching images. In the app, it is used to show the poster and backdrop image of the movie.

### Default (https://github.com/Nirma/Default)
`Default` is a library that extends what `UserDefaults` can do by providing extensions for saving custom objects

## Contributing

Feel free to open an issue or submit a pull request if you have any improvement or feedback.
