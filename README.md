MarkedView
========

[![Version](https://img.shields.io/cocoapods/v/MarkedView.svg?style=flat)](http://cocoadocs.org/docsets/MarkedView)
[![License](https://img.shields.io/cocoapods/l/MarkedView.svg?style=flat)](http://cocoadocs.org/docsets/MarkedView)
[![Platform](https://img.shields.io/cocoapods/p/MarkedView.svg?style=flat)](http://cocoadocs.org/docsets/MarkedView)



![img_gif](https://github.com/mittsuu/MarkedView-for-iOS/blob/master/markedview.gif)


## Introduction


The MarkedView is the markdown text viewer.

select the best one from UIWebview or WKWebview.

* UIMarkedView
    * UIWebView base


* WKMarkedView
    * WKWebView base


## Usage


It is a simple module, which enable you to convert any files into initialized view.  


```swift
// Swift
import MarkedView

・・・

// WKWebView base
let mdView = WKMarkedView()
// view set
self.view = mdView

// set Markdown text pattern
mdView.textToMark(contents)

// or load Markdown file pattern
// mdView.loadFile(filePath)

```


## Installation


MarkedView is available through [CocoaPods](https://cocoapods.org/).

To install it, simply add the following line to your ``` Podfile ```:


```
pod 'MarkedView'
```

Then run the following command:

```
$ pod install
```

## See Also

* MarkedView-for-Android  
https://github.com/mittsuu/MarkedView-for-Android


## Credits

This used the following open source components.

[Marked](https://github.com/chjj/marked) : Markdown parser written in JavaScript

[highlight.js](https://highlightjs.org/) : Syntax highlighting for the Web


## License


MarkedView is available under the MIT license. See the [LICENSE](https://github.com/mittsuu/MarkedView-for-iOS/blob/master/LICENSE) file for more info.
