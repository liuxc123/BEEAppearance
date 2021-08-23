//
//  NSObject+BEEAppearance.m
//  BEEAppearance
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "NSObject+BEEAppearance.h"
#import "BEEAppearanceManager.h"
#import <objc/runtime.h>

@implementation NSObject (BEEAppearance)

- (void)setThemeDidChange:(void (^)(NSString*, id))themeDidChange {
    objc_setAssociatedObject(self, @selector(themeDidChange), themeDidChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (themeDidChange) {
        [[BEEAppearanceManager sharedManager] addTrackedWithObject:self];
    } else {
        [[BEEAppearanceManager sharedManager] removeTrackedWithObject:self];
    }
}

- (void (^)(NSString*, id))themeDidChange {
    return objc_getAssociatedObject(self, @selector(themeDidChange));
}

@end
