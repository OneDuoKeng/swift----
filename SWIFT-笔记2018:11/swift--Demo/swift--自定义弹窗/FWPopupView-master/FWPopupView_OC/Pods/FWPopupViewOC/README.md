# IOS之弹窗 -- OC/[Swift4.x](https://github.com/choiceyou/FWPopupView)

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](http://cocoapods.org/?q=FWPopupView)&nbsp;
![Language](https://img.shields.io/badge/language-swift-orange.svg?style=flat)&nbsp;
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/choiceyou/FWPopupView/blob/master/FWPopupView/LICENSE)



## 支持pod导入：

```cocoaPods
pod 'FWPopupViewOC'
注意：如出现 [!] Unable to find a specification for 'FWPopupViewOC' 错误，可执行 pod repo update 命令。
```




## 简单使用：

### OC：<br>
```oc
只需要继承FWPopupBaseView：

@interface FWCustomView : FWPopupBaseView
@end

```



## 可设置参数：
```参数
/**
 标题字体大小
 */
@property (nonatomic, assign) CGFloat titleFontSize;
/**
 标题文字颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 按钮字体大小
 */
@property (nonatomic, assign) CGFloat buttonFontSize;
/**
 按钮高度
 */
@property (nonatomic, assign) CGFloat buttonHeight;
/**
 普通按钮文字颜色
 */
@property (nonatomic, strong) UIColor *itemNormalColor;
/**
 高亮按钮文字颜色
 */
@property (nonatomic, strong) UIColor *itemHighlightColor;
/**
 选中按钮文字颜色
 */
@property (nonatomic, strong) UIColor *itemPressedColor;

/**
 上下间距
 */
@property (nonatomic, assign) CGFloat topBottomMargin;
/**
 左右间距
 */
@property (nonatomic, assign) CGFloat letfRigthMargin;
/**
 控件之间的间距
 */
@property (nonatomic, assign) CGFloat commponentMargin;

/**
 边框、分割线颜色
 */
@property (nonatomic, strong) UIColor *splitColor;
/**
 边框宽度
 */
@property (nonatomic, assign) CGFloat splitWidth;
/**
 圆角值
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 弹窗的背景色（注意：这边指的是弹窗而不是遮罩层，遮罩层背景色的设置是：fwMaskViewColor）
 */
@property (nonatomic, strong) UIColor *backgroundColor;
/**
 弹窗的最大高度，0：表示不限制
 */
@property (nonatomic, assign) CGFloat popupViewMaxHeight;

/**
 弹窗箭头的样式
 */
@property (nonatomic, assign) FWPopupArrowStyle popupArrowStyle;
/**
 弹窗箭头的尺寸
 */
@property (nonatomic, assign) CGSize popupArrowSize;
/**
 弹窗箭头的顶点的X值相对于弹窗的宽度，默认在弹窗X轴的一半，因此设置范围：0~1
 */
@property (nonatomic, assign) CGFloat popupArrowVertexScaleX;
/**
 弹窗圆角箭头的圆角值
 */
@property (nonatomic, assign) CGFloat popupArrowCornerRadius;
/**
 弹窗圆角箭头与边线交汇处的圆角值
 */
@property (nonatomic, assign) CGFloat popupArrowBottomCornerRadius;


// ===== 自定义弹窗（继承FWPopupView）时可能会用到 =====

/**
 弹窗校准位置
 */
@property (nonatomic, assign) FWPopupAlignment popupAlignment;
/**
 弹窗动画类型
 */
@property (nonatomic, assign) FWPopupAnimationStyle popupAnimationStyle;

/**
 弹窗偏移量
 */
@property (nonatomic, assign) UIEdgeInsets popupEdgeInsets;
/**
 遮罩层的背景色（也可以使用fwMaskViewColor），注意：该参数在弹窗隐藏后，还原为弹窗弹起时的值
 */
@property (nonatomic, strong) UIColor *maskViewColor;

/**
 0表示NO，1表示YES，YES：用户点击外部遮罩层页面可以消失，注意：该参数在弹窗隐藏后，还原为弹窗弹起时的值
 */
@property (nonatomic, copy) NSString *touchWildToHide;

/**
 显示、隐藏动画所需的时间
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 3D放射动画（当且仅当：popupAnimationStyle == .scale3D 时有效）
 */
@property (nonatomic, assign) CATransform3D transform3D;
/**
 2D放射动画
 */
@property (nonatomic, assign) CGAffineTransform transform;
```



## 效果：
![](https://github.com/choiceyou/FWPopupViewOC/blob/master/%E6%95%88%E6%9E%9C/%E6%95%88%E6%9E%9C1.gif)
![](https://github.com/choiceyou/FWPopupViewOC/blob/master/%E6%95%88%E6%9E%9C/%E6%95%88%E6%9E%9C3.gif)
![](https://github.com/choiceyou/FWPopupViewOC/blob/master/%E6%95%88%E6%9E%9C/%E6%95%88%E6%9E%9C2.gif)
![](https://github.com/choiceyou/FWPopupViewOC/blob/master/%E6%95%88%E6%9E%9C/IMG_0724.PNG)


## 更新记录：

```更新记录
• v2.1.0 ：
  1.弹窗基类（FWPopupBaseView）中增加让多余部分的遮罩层变为无色属性：shouldClearSpilthMask；
  2.新增新手引导弹窗：FWGuideMaskView；
  
• v2.1.1 ：
  1.新增拖动关闭的弹窗基类：FWPanPopupView；
  
• v2.1.2 ：
  1.修复点击非遮罩层视图会显示的问题；
  
• v2.1.3 ：
  1.修复弹窗为成员变量时，再次调起弹窗后位置发生变化的问题；
  
• v2.1.4 ：
  1.增加：保证前一次弹窗销毁的处理机制；
  
• v2.1.5 ：
  1.修复弹窗消失时内存泄漏问题；
  
• v2.1.6 ：
  1.修复xib加载View方式时，继承弹窗基类FWPopupBaseView崩溃问题；
  
• v2.1.9 ：
  1.添加弹窗状态：FWPopupState；
  2.根据状态对应的进行回调，这样子可以根据实际使用来回调，废除原：showWithBlock 和 hideWithBlock 方法，新增：showWithDidAppearBlock、showWithStateBlock、hideWithDidDisappearBlock 方法；
```



## 结尾语：

- 使用过程中发现bug请issues或（QQ群：670698309）；
- 有新的需求欢迎提出；
