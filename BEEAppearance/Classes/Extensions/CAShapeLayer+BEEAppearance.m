//
//  CAShapeLayer+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "CAShapeLayer+BEEAppearance.h"
#import "NSObject+BEEAppearance.h"
#import "UIColor+BEEAppearance.h"
#import <objc/runtime.h>

@implementation CAShapeLayer (BEEAppearance)

+ (void)load {
    CAShapeLayer.methodExchange(@selector(setFillColor:), @selector(setFillThemeColor:));
    CAShapeLayer.methodExchange(@selector(setStrokeColor:), @selector(setStrokeThemeColor:));
}

- (void)setFillThemeColor:(id)fillThemeColor {
    if ([fillThemeColor isKindOfClass:UIColor.class]) {
        [self setFillThemeColor:(id)[fillThemeColor CGColor]];
        if ([fillThemeColor isTheme]) {
            objc_setAssociatedObject(self, @selector(fillThemeColor), fillThemeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [self setFillThemeColor:fillThemeColor];
    }
}

- (UIColor *)fillThemeColor {
    return objc_getAssociatedObject(self, @selector(fillThemeColor));
}

- (void)setStrokeThemeColor:(id)strokeThemeColor {
    if ([strokeThemeColor isKindOfClass:UIColor.class]) {
        [self setStrokeThemeColor:(id)[strokeThemeColor CGColor]];
        if ([strokeThemeColor isTheme]) {
            objc_setAssociatedObject(self, @selector(strokeThemeColor), strokeThemeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [self setStrokeThemeColor:strokeThemeColor];
    }
}

- (UIColor *)strokeThemeColor {
    return objc_getAssociatedObject(self, @selector(strokeThemeColor));
}

@end
