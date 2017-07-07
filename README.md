# ACFloatingInput

[![CI Status](http://img.shields.io/travis/mietelski-robert/ACFloatingInput.svg?style=flat)](https://travis-ci.org/mietelski-robert/ACFloatingInput)
[![Version](https://img.shields.io/cocoapods/v/ACFloatingInput.svg?style=flat)](http://cocoapods.org/pods/ACFloatingInput)
[![License](https://img.shields.io/cocoapods/l/ACFloatingInput.svg?style=flat)](http://cocoapods.org/pods/ACFloatingInput)
[![Platform](https://img.shields.io/cocoapods/p/ACFloatingInput.svg?style=flat)](http://cocoapods.org/pods/ACFloatingInput)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Input Mask

The table below shows the characters that can be used in an input mask. 

| Character |                                   Meaning                                   |
|:---------:|:---------------------------------------------------------------------------:|
|     A     | ASCII alphabetic character. A-Z, a-z.                                       |
|     N     | ASCII alphanumeric character. A-Z, a-z, 0-9.                                |
|     0     | ASCII digit. 0-9.                                                           |
|:---------:|:---------------------------------------------------------------------------:|

The mask consists of a string of mask characters and separators, optionally followed by a semicolon and the character used for blanks.

Examples:

|         Mask         |                               Notes                              |
|:--------------------:|:----------------------------------------------------------------:|
|      0000-00-00      | ISO Date; blanks are space                                       |
|   000.000.000.000;_  | IP address; blanks are _.                                        |
|   (000) AAA-AAAA;#   | U.S. style phone number with letters; blanks are #.              |
|:--------------------:|:----------------------------------------------------------------:|

## Installation

ACFloatingInput is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ACFloatingInput"
```

## Author

Robert Mietelski, mietelski.robert@gmail.com

## License

ACFloatingInput is available under the MIT license. See the LICENSE file for more info.
