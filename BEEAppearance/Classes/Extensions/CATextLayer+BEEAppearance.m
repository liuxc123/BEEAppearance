//
//  CATextLayer+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "CATextLayer+BEEAppearance.h"
#import "NSObject+BEEAppearance.h"
#import "UIColor+BEEAppearance.h"
#import <objc/runtime.h>

@implementation CATextLayer (BEEAppearance)

+ (void)load {
    self.methodExchange(@selector(setForegroundColor:), @selector(setForegroundThemeColor:));
}

- (void)setForegroundThemeColor:(id)foregroundThemeColor {
    if ([foregroundThemeColor isKindOfClass:UIColor.class]) {
        [self setForegroundThemeColor:(id)[foregroundThemeColor CGColor]];
        if ([foregroundThemeColor isTheme]) {
            objc_setAssociatedObject(self, @selector(foregroundThemeColor), foregroundThemeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [self setForegroundThemeColor:foregroundThemeColor];
    }
}

- (UIColor *)foregroundThemeColor {
    return objc_getAssociatedObject(self, @selector(foregroundThemeColor));
}

@end
