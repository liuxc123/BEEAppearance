//
//  NSObject+BEEAppearance.m
//  BEEAppearance
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "NSObject+BEEAppearance.h"
#import <objc/runtime.h>

@implementation NSObject (BEEAppearance)

- (void)setThemeDidChange:(void (^)(NSString*, id))themeDidChange {
    objc_setAssociatedObject(self, @selector(themeDidChange), themeDidChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString*, id))themeDidChange {
    return objc_getAssociatedObject(self, @selector(themeDidChange));
}

+ (void (^)(SEL _Nonnull, SEL _Nonnull))methodExchange {
    return ^(SEL sel1, SEL sel2) {
        method_exchangeImplementations(class_getInstanceMethod(self, sel1), class_getInstanceMethod(self, sel2));
    };
}

- (void)forinUIControlState:(void (^)(UIControlState, id))complete {
    for (NSNumber *obj in [NSObject ControlStateArray]) {
        UIControlState state = [obj integerValue];
        !complete ?: complete(state, self);
    }
}

- (void)forinUIBarMetrics:(void (^) (UIBarMetrics metrics, id obj))complete {
    for (NSNumber *obj in [NSObject BarMetricsArray]) {
        UIBarMetrics metrics = [obj integerValue];
        !complete ?: complete(metrics, self);
    }
}

- (void)forinUIBarPosition:(void (^) (UIBarPosition position, id obj))complete {
    for (NSNumber *obj in [NSObject BarPositionArray]) {
        UIBarPosition position = [obj integerValue];
        !complete ?: complete(position, self);
    }
}

- (void)forinUIBarButtonItemStyle:(void (^) (UIBarButtonItemStyle style, id obj))complete {
    for (NSNumber *obj in [NSObject BarButtonItemStyleArray]) {
        UIBarButtonItemStyle style = [obj integerValue];
        !complete ?: complete(style, self);
    }
}

- (void)forinUISearchBarIcon:(void (^) (UISearchBarIcon icon, id obj))complete {
    for (NSNumber *obj in [NSObject SearchBarIconArray]) {
        UISearchBarIcon icon = [obj integerValue];
        !complete ?: complete(icon, self);
    }
}

+ (NSArray<NSNumber *> *)ControlStateArray {
    static NSArray<NSNumber *> *controlStateArtray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controlStateArtray = @[
            @(UIControlStateNormal), @(UIControlStateDisabled),
            @(UIControlStateSelected), @(UIControlStateFocused), @(UIControlStateHighlighted)
        ];
    });
    return controlStateArtray;
}

+ (NSArray<NSNumber *> *)BarMetricsArray {
    static NSArray<NSNumber *> *barMetricsArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        barMetricsArray = @[
            @(UIBarMetricsDefault), @(UIBarMetricsCompact)
        ];
    });
    return barMetricsArray;
}

+ (NSArray<NSNumber *> *)BarPositionArray {
    static NSArray<NSNumber *> *BarPositionArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BarPositionArray = @[
            @(UIBarPositionAny), @(UIBarPositionTop),
            @(UIBarPositionTopAttached)
        ];
    });
    return BarPositionArray;
}

+ (NSArray<NSNumber *> *)BarButtonItemStyleArray {
    static NSArray<NSNumber *> *BarButtonItemStyleArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BarButtonItemStyleArray = @[
            @(UIBarButtonItemStylePlain), @(UIBarButtonItemStyleDone)
        ];
    });
    return BarButtonItemStyleArray;
}

+ (NSArray<NSNumber *> *)SearchBarIconArray {
    static NSArray<NSNumber *> *SearchBarIconArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SearchBarIconArray = @[
            @(UISearchBarIconSearch), @(UISearchBarIconClear), @(UISearchBarIconBookmark),
            @(UISearchBarIconResultsList)
        ];
    });
    return SearchBarIconArray;
}

@end
