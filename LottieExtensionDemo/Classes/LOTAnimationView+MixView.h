//
//  LOTAnimationView+MixView.h
//  Lottie-Example
//
//  涉及点击时，需注意事项：
//   1.当触摸点在多个自定义view内时，后添加的自定义view接收该点击。
//   2.当自定义view上被可见的lottie图层遮挡，但触摸点在自定义view内时，
//     可能误判为自定义view需要响应该点击（看不到的按钮响应了该点击，违反用户直觉判断）。
//     如有此种情况，业务要在target-action中根据动画的当前播放帧，判断是否要执行响应逻辑。
//   3.目前仅支持UIButton按钮点击，在自定义view中注册target-action即可，代码编写与原生开发相同。
//
//  Created by xxx on 2021/9/8.
//  Copyright © 2021 Brandon Withrow. All rights reserved.
//

#import "lottie.h"

NS_ASSUME_NONNULL_BEGIN

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

NS_ASSUME_NONNULL_END
