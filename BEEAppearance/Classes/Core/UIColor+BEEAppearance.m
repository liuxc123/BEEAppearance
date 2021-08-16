//
//  UIColor+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "UIColor+BEEAppearance.h"
#import "BEEAppearanceManager.h"
#import <objc/runtime.h>

@implementation UIColor (BEEAppearance)

- (void)setColorName:(NSString *)colorName {
    objc_setAssociatedObject(self, @selector(colorName), colorName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)colorName {
    return objc_getAssociatedObject(self, @selector(colorName));
}

- (void)setThemeProvider:(UIColor * _Nonnull (^)(NSString * _Nonnull))themeProvider {
    objc_setAssociatedObject(self, @selector(themeProvider), themeProvider, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor * (^)(NSString * _Nonnull))themeProvider {
    return objc_getAssociatedObject(self, @selector(themeProvider));
}

+ (UIColor *)colorWithThemeProvider:(BEEAppearanceColorThemeProvider)themeProvider {
    UIColor *color = themeProvider([BEEAppearanceManager sharedManager].currentThemeName);
    color.themeProvider = themeProvider;
    return color;
}

- (UIColor *)refreshAppearance {
    UIColor *tempColor = self;
    
    if (self.colorName) {
        tempColor = [BEEAppearanceManager themeColor:self.colorName];
    }
    
    if (self.themeProvider) {
        BEEAppearanceColorThemeProvider provider = self.themeProvider;
        tempColor = provider([[BEEAppearanceManager sharedManager] currentThemeName]);
        tempColor.themeProvider = provider;
    }
    return tempColor;
}

- (BOOL)isTheme {
    return self.colorName || self.themeProvider;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    
    if (!hexString) return nil;
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    CGFloat alpha, red, blue, green;
    
    switch ([colorString length]) {
        case 0:
            return nil;
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom:colorString start: 0 length: 1];
            green = [self colorComponentFrom:colorString start: 1 length: 1];
            blue  = [self colorComponentFrom:colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start: 0 length: 1];
            red   = [self colorComponentFrom:colorString start: 1 length: 1];
            green = [self colorComponentFrom:colorString start: 2 length: 1];
            blue  = [self colorComponentFrom:colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom:colorString start: 0 length: 2];
            green = [self colorComponentFrom:colorString start: 2 length: 2];
            blue  = [self colorComponentFrom:colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start: 0 length: 2];
            red   = [self colorComponentFrom:colorString start: 2 length: 2];
            green = [self colorComponentFrom:colorString start: 4 length: 2];
            blue  = [self colorComponentFrom:colorString start: 6 length: 2];
            break;
        default:
            alpha = 0;
            red = 0;
            blue = 0;
            green = 0;
            break;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CGFloat)colorComponentFrom:(NSString *) string start:(NSUInteger)start length:(NSUInteger) length{
    
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0f;
}


@end

