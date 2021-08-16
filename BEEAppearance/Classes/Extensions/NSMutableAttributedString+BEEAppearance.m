//
//  NSMutableAttributedString+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "NSMutableAttributedString+BEEAppearance.h"
#import "BEEAppearanceDefine.h"
#import "UIColor+BEEAppearance.h"
#import "UIImage+BEEAppearance.h"
#import <CoreText/CTStringAttributes.h>

@implementation NSMutableAttributedString (BEEAppearance)

- (void)refreshAppearance {
    if (bee_ObjectIsEmpty(self)) return;

    [self enumerateAttributesInRange:NSMakeRange(0, self.length) options:kNilOptions usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        for (NSString *key in attributedStringKey()) {
            id obj = [attrs objectForKey:key];
            
            if (!obj) continue;
            
            if ([obj isKindOfClass:UIColor.class]) {
                UIColor *color = (UIColor *)obj;
                if (color.isTheme) {
                    color = [color refreshAppearance];
                    [self addAttribute:key value:color range:range];
                    if ([key isEqualToString:NSForegroundColorAttributeName]) {
                        [self addAttribute:(id)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
                    }
                }
                continue;
            }
            
            if ([obj isKindOfClass:NSShadow.class]) {
                NSShadow *shadow = (NSShadow *)obj;
                UIColor *shadowColor = shadow.shadowColor;
                if ([shadowColor isKindOfClass:UIColor.class] &&
                    shadowColor.isTheme) {
                    shadow.shadowColor = [shadowColor refreshAppearance];
                    [self addAttribute:key value:shadow range:range];
                }
                continue;
            }
            
            if ([obj isKindOfClass:NSTextAttachment.class]) {
                NSTextAttachment *attachment = (NSTextAttachment *)obj;
                if (attachment.image.isTheme) {
                    attachment.image = [attachment.image refreshAppearance];
                    [self addAttribute:key value:attachment range:range];
                }
                continue;
            }
        }
    }];
}

@end
