# BEEAppearance主题管理类

功能实现原理基于：

[百度APP iOS暗黑模式适配的完美解决方案](https://baijiahao.baidu.com/s?id=1653227966920525709&wfr=spider&for=pc)


# 使用

### 基础配置

```
/// 注册主题

AppearanceManager.addTheme(["color": ["backgroundColor": "#f0f0f0"], "image": ["car": "car1"]], themeName: "default")
        
AppearanceManager.addTheme(["color": ["backgroundColor": "#000000"], "image": ["car": "car2"]], themeName: "dark")
        
/// 设置默认主题
AppearanceManager.defaultTheme("default")

/// 切换主题
AppearanceManager.changeTheme("dark")

```

### 控件使用

#### 基础使用

```
/// 设置颜色
self.view.backgroundColor = BEEAppearanceColor("backgroundColor")

/// 设置图片
self.imageView.image = BEEAppearanceImage(@"car")

/// 设置layer的颜色
self.view.layer.borderColor = BEEAppearanceCGColor(theme_textlabel3)
```

#### 自定义设置
```
self.view.themeDidChange = { themeName, bindView in
    /// 自定义主题
}
```

## 安装

BEEAppearance is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BEEAppearance'
```

## 作者

liuxc123, lxc_work@126.com

## 声明

BEEAppearance is available under the MIT license. See the LICENSE file for more info.
