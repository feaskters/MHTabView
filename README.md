# MHTabView

[![CI Status](https://img.shields.io/travis/ZhangMingHao/MHTabView.svg?style=flat)](https://travis-ci.org/ZhangMingHao/MHTabView)
[![Version](https://img.shields.io/cocoapods/v/MHTabView.svg?style=flat)](https://cocoapods.org/pods/MHTabView)
[![License](https://img.shields.io/cocoapods/l/MHTabView.svg?style=flat)](https://github.com/feaskters/MHTabView/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/MHTabView.svg?style=flat)](https://cocoapods.org/pods/MHTabView)

- An easy way to use scroll tab bar

## Contents

- [Installation](#Installation)

- [Getting Started](#Getting-Started)
  + [usage](#usage)

- [Example](#Example)
  + [unscrollable](#unscrollable)
  + [scrollable](#scrollable)
  + [autoscrollable](#autoscrollable)
  + [autoUnscrollable](#autoUnscrollable)
  + [other](#other)
- [Author](#Author)
- [License](#License)

## Installation

MHTabView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MHTabView'
```

## Getting Started

### usage

There are two ways to create your own tabview

 1. convenience init
 ```swift
 let tabview = MHTabView.init(withTitles: titles, pageViews: views)
 ```
 
 2. init and set titles and pageviews
 ```swift
 let tabview = MHTabView.init()
 tabview.setTitlesAndPageViews(titles: titles, pageViews: views)
 ```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

 - ### unscrollable

```swift
tabview.titleStyle = .unscrollable
```
![unscrollable](https://s1.ax1x.com/2020/04/27/JfzBqg.gif)

 - ### scrollable

```swift
tabview.titleStyle = .scrollable
```

![scrollable](https://s1.ax1x.com/2020/04/27/JfgfKS.gif)

 - ### autoscrollable

```swift
tabview.titleStyle = .autoScrollable
```

![autoscrollable](https://s1.ax1x.com/2020/04/27/JfzrZQ.gif)

 - ### autoUnscrollable

```swift
tabview.titleStyle = .autoUnscrollable
```

![autoUnscrollable](https://s1.ax1x.com/2020/04/27/Jfz0sS.gif)

 - ### other
 
  1. change color
  ```swift
  tabview.defaultColor = .blue
  tabview.selectedColor = .red
  tabview.indicatorView.backgroundColor = .green
  ```
  
  2. change width for scrollable style
  ```swift
  tabview.style = .scrollable
  tabview.tabWidth = 150
  ```
  
  3. usage of delegate
  
  ```swift
  protocol MHTabViewDelegate {
    /**停止滚动后的回调函数(index, scrollview) -> (当前滚动到的位置, scrollView属性 )*/
    func MHTabViewDidEndDecelerating(_ index: Int, _ scrollview: UIScrollView)
  }
  ```
  
  4. other APIs
  ```swift
  setSelectedFont(_ font: UIFont)//修改选中按钮的字体
  
  setUnSelectedFont(_ font: UIFont)//修改未选中按钮的字体
  
  setIndicatorHeight(_ height: CGFloat)//修改指示器高度
  
  setIndicatorWidth(_ width: CGFloat)//修改指示器宽度
  ```

  ![delegate](https://s1.ax1x.com/2020/04/27/JfgEAs.gif)

## Author

ZhangMingHao, 739296759@qq.com

## License

MHTabView is available under the MIT license. See the LICENSE file for more info.
