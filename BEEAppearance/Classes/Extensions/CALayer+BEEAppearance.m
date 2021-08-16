//
//  CALayer+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "CALayer+BEEAppearance.h"
#import "NSObject+BEEAppearanceInteral.h"
#import "UIColor+BEEAppearance.h"
#import "UIImage+BEEAppearance.h"
#import "CATextLayer+BEEAppearance.h"
#import "NSMutableAttributedString+BEEAppearance.h"
#import "CAShapeLayer+BEEAppearance.h"
#import "CAGradientLayer+BEEAppearance.h"
#import <objc/runtime.h>

@implementation CALayer (BEEAppearance)

+ (void)load {
    self.methodExchange(@selector(setBackgroundColor:), @selector(setBackgroundThemeColor:));
    self.methodExchange(@selector(setBorderColor:), @selector(setBorderThemeColor:));
    self.methodExchange(@selector(setShadowColor:), @selector(setShadowThemeColor:));
    self.methodExchange(@selector(setContents:), @selector(setContentImage:));
}

- (void)setBackgroundThemeColor:(id)backgroundThemeColor {
    if ([backgroundThemeColor isKindOfClass:UIColor.class]) {
        [self setBackgroundThemeColor:(id)[backgroundThemeColor CGColor]];
        if ([backgroundThemeColor isTheme]) {
            objc_setAssociatedObject(self, @selector(backgroundThemeColor), backgroundThemeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [self setBackgroundThemeColor:backgroundThemeColor];
    }
}

- (UIColor *)backgroundThemeColor {
    return objc_getAssociatedObject(self, @selector(backgroundThemeColor));
}

- (void)setBorderThemeColor:(id)borderThemeColor {
    if ([borderThemeColor isKindOfClass:UIColor.class]) {
        [self setBorderThemeColor:(id)[borderThemeColor CGColor]];
        if ([borderThemeColor isTheme]) {
            objc_setAssociatedObject(self, @selector(borderThemeColor), borderThemeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [self setBorderThemeColor:borderThemeColor];
    }
}

- (UIColor *)borderThemeColor {
    return objc_getAssociatedObject(self, @selector(borderThemeColor));
}

- (void)setShadowThemeColor:(UIColor *)shadowThemeColor {
    if ([shadowThemeColor isKindOfClass:UIColor.class]) {
        [self setShadowThemeColor:(id)[shadowThemeColor CGColor]];
        if ([shadowThemeColor isTheme]) {
            objc_setAssociatedObject(self, @selector(shadowThemeColor), shadowThemeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [self setShadowThemeColor:shadowThemeColor];
    }
}

- (UIColor *)shadowThemeColor {
    return objc_getAssociatedObject(self, @selector(shadowThemeColor));
}

- (void)setContentImage:(id)contentImage {
    if ([contentImage isKindOfClass:UIImage.class]) {
        UIImage *image = (UIImage *)contentImage;
        [self setContentImage:(id)image.CGImage];
        if ([image isTheme]) {
            objc_setAssociatedObject(self, @selector(contentImage), contentImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else {
        [self setContentImage:contentImage];
    }
}

- (UIImage *)contentImage {
    return objc_getAssociatedObject(self, @selector(contentImage));
}

#pragma mark - Refresh

- (void)refreshAppearance {
    for (CALayer *layer in self.sublayers) {
        [layer refreshSingleLayer];
    }
}

- (void)refreshSingleLayer {

    // 刷新通用属性
    UIColor *backgroundColor = self.backgroundThemeColor;
    if (backgroundColor.isTheme) {
        self.backgroundColor = (__bridge CGColorRef)[backgroundColor refreshAppearance];
    }
    
    UIColor *borderColor = self.borderThemeColor;
    if (borderColor.isTheme) {
        self.borderColor = (__bridge CGColorRef)[borderColor refreshAppearance];
    }
    
    UIColor *shadowColor = self.shadowThemeColor;
    if (shadowColor.isTheme) {
        self.shadowColor = (__bridge CGColorRef)[shadowColor refreshAppearance];
    }
    
    UIImage *image = self.contentImage;
    if (image.isTheme) {
        self.contents = [image refreshAppearance];
    }
    
    if ([self isKindOfClass:CATextLayer.class]) {
        CATextLayer *t_textLayer = (CATextLayer *)self;
        
        UIColor *foregroundColor = t_textLayer.foregroundThemeColor;
        if (foregroundColor.isTheme) {
            t_textLayer.foregroundColor = (__bridge CGColorRef)[foregroundColor refreshAppearance];
        }
        
        if ([t_textLayer.string isKindOfClass:NSAttributedString.class]) {
            NSMutableAttributedString *t_attr = [t_textLayer.string mutableCopy];
            [t_attr refreshAppearance];
            t_textLayer.string = t_attr;
        }
        
        return;
    }
    
    if ([self isKindOfClass:CAShapeLayer.class]) {
        CAShapeLayer *t_shapeLayer = (CAShapeLayer *)self;
        
        UIColor *fillColor = t_shapeLayer.fillThemeColor;
        if (fillColor.isTheme) {
            t_shapeLayer.fillColor = (__bridge CGColorRef)[fillColor refreshAppearance];
        }
        
        UIColor *strokeColor = t_shapeLayer.strokeThemeColor;
        if (strokeColor.isTheme) {
            t_shapeLayer.strokeColor = (__bridge CGColorRef)[strokeColor refreshAppearance];
        }
        return;
    }

}

@end
