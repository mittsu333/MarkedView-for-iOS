## MarkedView Example


![img_gif](https://github.com/mittsuu/MarkedView-for-iOS/blob/master/markedview.gif)


## Introduction


The MarkedView is the markdown text viewer.

select the best one from UIWebview or WKWebview.

* UIMarkedView
* UIWebView base


* WKMarkedView
* WKWebView base


## Usage


The same process except the initialization.

Call is available from any text from any file .

```
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

## License


MarkedView is available under the MIT license. See the LICENSE file for more info.
