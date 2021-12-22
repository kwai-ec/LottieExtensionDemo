//
//  LOTAnimationView+MixView.m
//  Lottie-Example
//
//  Created by xxx on 2021/9/8.
//  Copyright © 2021 Brandon Withrow. All rights reserved.
//

#import "LOTAnimationView+MixView.h"
#import <objc/runtime.h>

#define kLOTAnimationView_Key_MixViews @"kLOTAnimationView_Key_MixViews"

@interface LOTAnimationView (forward)
@property (nonatomic, strong) NSMutableArray *mixLayers;
- (void)_layoutAndForceUpdate;
@end
@interface LOTLayerContainer : CALayer
@property (nonatomic,  readonly, strong, nullable) NSString *layerName;
@property (nonatomic, readonly, nonnull) CALayer *wrapperLayer;

@end
@interface LOTCompositionContainer : LOTLayerContainer
@property (nonatomic, readonly, nonnull) NSArray<LOTLayerContainer *> *childLayers;
@property (nonatomic, readonly, nonnull)  NSDictionary *childMap;
@property (nonatomic, nullable) NSNumber *currentFrame;
- (CALayer *)_layerForKeypath:(nonnull LOTKeypath *)keypath;
@end

@interface LOTAnimationView ()
@property (nonatomic, strong) NSMutableArray<CALayer *> *mixLayers;
@end

@implementation LOTAnimationView (MixView)
- (void)addSubview:(nonnull UIView *)view
    withLayerName:(nonnull NSString *)layerName {
    [self addSubview:view withLayerName:layerName removeOriginal:YES];
}

- (void)addSubview:(nonnull UIView *)view
    withLayerName:(nonnull NSString *)layerName
    removeOriginal:(BOOL)removeOriginal {
    CALayer *layer = [self searchWithLayerName:layerName];
    if (layer) {
        [self _layoutAndForceUpdate];
        CGRect viewRect = view.frame;
        LOTView *wrapperView = [[LOTView alloc] initWithFrame:viewRect];
        view.frame = view.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [wrapperView addSubview:view];
        [self addSubview:wrapperView];
        if (removeOriginal) {
            layer.contents = nil;
        }
        [layer addSublayer:wrapperView.layer];
        NSValue *value = [NSValue valueWithNonretainedObject:view.layer];
        [self.mixLayers addObject:value];
    }
}

- (CALayer *)searchWithLayerName:(NSString *)layerName
{
    CALayer *layer = [self normalSearchWithLayerName:layerName];
    if (!layer) {
        layer = [self customSearchWithLayerName:layerName];
    }
    return layer;
}

- (CALayer *)normalSearchWithLayerName:(NSString *)layerName
{
    LOTCompositionContainer *_compContainer = [self valueForKey:@"_compContainer"];
    LOTKeypath *keypath = [LOTKeypath keypathWithString:layerName];
    CALayer *layer = [_compContainer _layerForKeypath:keypath];
    return layer;
}

- (CALayer *)customSearchWithLayerName:(NSString *)layerName
{
    LOTCompositionContainer *_compContainer = [self valueForKey:@"_compContainer"];
    LOTLayerContainer *layerContainer = [self traversLayer:_compContainer withLayerName:layerName];
    return layerContainer.wrapperLayer;
}

- (LOTLayerContainer *)traversLayer:(LOTCompositionContainer *)layer withLayerName:(NSString *)layerName
{
    if ([layer.layerName isEqualToString:layerName]) {
        return layer;
    }
    else if ([layer isKindOfClass:[LOTCompositionContainer class]]) {
        for (LOTCompositionContainer *sublayer in layer.childLayers) {
            LOTLayerContainer *targetLayer = [self traversLayer:sublayer withLayerName:layerName];
            if (targetLayer) {
                return targetLayer;
            }
        }
    }
    return nil;
}

# pragma mark - property
- (NSMutableArray *)mixLayers
{
    NSMutableArray *arr = objc_getAssociatedObject(self, kLOTAnimationView_Key_MixViews);
    if (!arr) {
        arr = [NSMutableArray new];
        [self setMixLayers:arr];
    }
    return arr;
}
- (void)setMixLayers:(NSMutableArray *)mixLayers
{
    objc_setAssociatedObject(self, kLOTAnimationView_Key_MixViews, mixLayers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)currentFrame
{
    LOTCompositionContainer *_compContainer = [self valueForKey:@"_compContainer"];
    return [(LOTCompositionContainer *)_compContainer.presentationLayer currentFrame];
}
@end
