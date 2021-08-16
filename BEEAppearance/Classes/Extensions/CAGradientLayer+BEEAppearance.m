//
//  CAGradientLayer+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "CAGradientLayer+BEEAppearance.h"
#import "NSObject+BEEAppearance.h"
#import "UIColor+BEEAppearance.h"
#import <objc/runtime.h>

@implementation CAGradientLayer (BEEAppearance)

+ (void)load {
    self.methodExchange(@selector(setColors:), @selector(setThemeColors:));
}

- (void)setThemeColors:(NSArray *)themeColors {
    NSMutableArray *t_arr = [NSMutableArray array];
    BOOL isThemeColor = NO;
    for (UIColor *color in themeColors) {
        if ([color isKindOfClass:UIColor.class]) {
            [t_arr addObject:(id)color.CGColor];
            if (color.isTheme) isThemeColor = YES;
        } else {
            [t_arr addObject:color];
        }
    }
    
    if (isThemeColor == YES) {
        objc_setAssociatedObject(self, @selector(themeColors), themeColors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    [self setThemeColors:t_arr];
}

- (NSArray *)themeColors {
    return objc_getAssociatedObject(self, @selector(themeColors));
}


@end
