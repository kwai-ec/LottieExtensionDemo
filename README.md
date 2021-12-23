# LottieExtensionDemo
支持Native混合渲染和点击响应的DEMO工程

文章链接：https://juejin.cn/post/7044377071199453192

# Classes目录
    Lottie能力扩展的核心实现，可以直接拷贝到你的工程
    
    需注意工程里面引用lottie的方式#import "lottie.h"，要根据你的项目工程方式更改
# biz目录
    依赖核心实现，业务需求的落地示例
    
    hongbao.json文件为lottie原文件，使用到的图片在Assets.xcassets中 
    
    为简便起见，自定义要替换的view用xib实现，即工程中的HongBaoView.xib
    

# 接口使用示例
```
  #import "LOTAnimationView+MixView.h"

  [self.lottieView addSubview:view withLayerName:@"卡"];
  ```
    
# 接口定义
```

@interface LOTAnimationView (MixView)

/// Lottie动画当前的播放帧
@property (nonatomic, readonly) NSNumber *currentFrame;

/// 替换Lottie动画中的指定图层为自定义视图
/// @param view 自定义实现的视图实例
/// @param layerName Lottie动画中将要被替换为自定义视图的图层名称
- (void)addSubview:(nonnull UIView *)view
     withLayerName:(nonnull NSString *)layerName;

/// 替换Lottie动画中的指定图层为自定义视图
/// @param view 自定义实现的视图实例
/// @param layerName Lottie动画中将要被替换为自定义视图的图层名称
/// @param removeOriginal 是否要清除被替换图像图层的原始图像
- (void)addSubview:(nonnull UIView *)view
     withLayerName:(nonnull NSString *)layerName
    removeOriginal:(BOOL)removeOriginal;
@end
```


