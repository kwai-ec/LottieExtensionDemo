//
//  LOTAnimationView+interactionEnabled.m
//  Lottie-Example
//
//  Created by xxx on 2021/9/8.
//  Copyright © 2021 Brandon Withrow. All rights reserved.
//

#import "LOTAnimationView+interactionEnabled.h"
#import "LOTAnimationView+MixView.h"

@interface LOTAnimationView (forward)
@property (nonatomic, strong) NSArray<CALayer *> *mixLayers;
@end

@implementation LOTAnimationView (interactionEnabled)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 方案1.将自定义替换的同层layer缓存起来，触摸测试时，只在缓存的替换自定义View中做point包含判断
    // 问题：！！！如果自定义view之上遮盖了可见layer，自定义view错误响应点击
    NSArray *reversedItems = [[self.mixLayers reverseObjectEnumerator] allObjects];
        for (NSValue *value in reversedItems) {
            CALayer *layer = [value nonretainedObjectValue];
            if (![layer isKindOfClass:[CALayer class]]) {
                continue;
            }
            CGPoint newPoint = [self.layer.presentationLayer convertPoint:point toLayer:layer.presentationLayer];
            CALayer *origLayer = layer.superlayer.superlayer;
            BOOL ignore4Opacity = NO;
            while (origLayer != self.layer && origLayer.allowsGroupOpacity) {
                if (origLayer.opacity < 0.1) {
                    ignore4Opacity = YES;
                    break;
                }
                origLayer = origLayer.superlayer;
            }
            if (!ignore4Opacity
                && [layer.presentationLayer containsPoint:newPoint]
                && [layer.delegate isKindOfClass:[UIView class]]) {
                return [(UIView *)layer.delegate hitTest:newPoint withEvent:event];
            }
        }
       return [super hitTest:point withEvent:event];
    
//     方案二.直接使用CALayer.hitTest去查找命中的layer，
//     问题：上面盖了一层透明的layer，或者png的透明区域时，点击不能穿透，设计难以保证
//     CGPoint newPoint = [self convertPoint:point toView:self.superview];
//     CALayer *layer = [self.layer.presentationLayer hitTest:newPoint].modelLayer;
//     UIView *view = (UIView *)layer.delegate;
//      //UIView *tipView = [UIView new];
//      //tipView.frame = layer.bounds;
//      //tipView.backgroundColor = [UIColor blackColor];
//      //[layer addSublayer:tipView.layer];
//     if ([layer.delegate isKindOfClass:[UIView class]]) {
//         return [view hitTest:newPoint withEvent:event];;
//     }
//     return [super hitTest:point withEvent:event];
}

@end
