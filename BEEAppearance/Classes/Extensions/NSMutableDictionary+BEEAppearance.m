//
//  NSMutableDictionary+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "NSMutableDictionary+BEEAppearance.h"
#import "BEEAppearanceDefine.h"
#import "UIColor+BEEAppearance.h"
#import "UIImage+BEEAppearance.h"

@implementation NSMutableDictionary (BEEAppearance)

- (void)refreshAppearance {
    if (bee_ObjectIsEmpty(self)) return;
    
    for (NSString *key in attributedStringKey()) {
        id value = [self objectForKey:key];
        
        if (!value) continue;
        
        if ([value isKindOfClass:UIColor.class]) {
            UIColor *color = (UIColor *)value;
            if (color.isTheme) {
                color = [color refreshAppearance];
                [self setValue:color forKey:key];
            }
            continue;
        }
        
        if ([value isKindOfClass:NSShadow.class]) {
            NSShadow *shadow = (NSShadow *)value;
            UIColor *shadowColor = shadow.shadowColor;
            if ([shadowColor isKindOfClass:UIColor.class] &&
                shadowColor.isTheme) {
                shadow.shadowColor = [shadowColor refreshAppearance];
                [self setValue:shadow forKey:key];
            }
            continue;
        }
        
        if ([value isKindOfClass:NSTextAttachment.class]) {
            NSTextAttachment *attachment = (NSTextAttachment *)value;
            if (attachment.image.isTheme) {
                attachment.image = [attachment.image refreshAppearance];
                [self setValue:attachment forKey:key];
            }
            continue;
        }
    }
}

@end
