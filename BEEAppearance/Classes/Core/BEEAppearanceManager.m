//
//  BEEAppearanceManager.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/12.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEEAppearanceManager.h"
#import "UIColor+BEEAppearance.h"
#import "UIImage+BEEAppearance.h"
#import "UIView+BEEAppearance.h"
#import "NSObject+BEEAppearance.h"
#import <objc/runtime.h>

UIColor* BEEAppearanceColor(NSString *colorName) {
    return [BEEAppearanceManager themeColor:colorName];
}

CGColorRef BEEAppearanceCGColor(NSString *colorName) {
    return (__bridge CGColorRef)[BEEAppearanceManager themeColor:colorName];
}

UIImage* BEEAppearanceImage(NSString *imageName) {
    return [BEEAppearanceManager themeImage:imageName];
}

#pragma mark - BEEAppearanceManager

@interface BEEAppearanceManager ()

@property (nonatomic, strong, readwrite) NSString *currentThemeName;
@property (nonatomic, strong, readwrite) NSMutableDictionary *themeConfigs;
@property (nonatomic, strong, readwrite) NSHashTable *trackedHashTable;

@end

@implementation BEEAppearanceManager

#pragma mark - initial

+ (instancetype)sharedManager {
    static BEEAppearanceManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [BEEAppearanceManager new];
    });
    
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _trackedHashTable = [NSHashTable weakObjectsHashTable];
        _themeConfigs = [NSMutableDictionary dictionary];
        _currentThemeName = @"";
    }
    return self;
}

#pragma mark - public methods

+ (void)defaultTheme:(NSString *)themeName {
    
    if (!themeName) { return; }
    
    NSAssert([[BEEAppearanceManager sharedManager].themeConfigs.allKeys containsObject:themeName], @"所启用的主题不存在 - 请检查是否添加了该%@主题的设置" , themeName);
    
    BEEAppearanceManager *manager = [BEEAppearanceManager sharedManager];
    manager.currentThemeName = themeName;
}

- (void)addTheme:(NSDictionary<NSString*, NSDictionary<NSString*, NSString*>*> *)config themeName:(NSString *)name {
    
    if (!name) { return; }
    
    if (!config) { return; }

    [self.themeConfigs setValue:config forKey:name];
}

- (void)changeTheme:(NSString *)themeName {
    
    NSAssert([[BEEAppearanceManager sharedManager].themeConfigs.allKeys containsObject:themeName], @"所启用的主题不存在 - 请检查是否添加了该%@主题的设置" , themeName);
    
    if (!themeName) { return; }

    self.currentThemeName = themeName;
    
    __weak typeof(self) weakSelf = self;
    [self.trackedHashTable.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf refreshTargetObject:obj];
    }];
    
    /// 发送主题已改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeDidChangeNotification object:[BEEAppearanceManager sharedManager].currentThemeName];
}

+ (NSDictionary *)themeConfig:(NSString *)themeName {
    BEEAppearanceManager *manager = [BEEAppearanceManager sharedManager];
    return manager.themeConfigs[themeName];
}

+ (UIColor *)themeColor:(NSString *)colorName {
    BEEAppearanceManager *manager = [BEEAppearanceManager sharedManager];
    NSString *value = manager.themeConfigs[manager.currentThemeName][@"color"][colorName];
    UIColor *color = [UIColor colorWithHexString:value] ?: [UIColor clearColor];
    color.colorName = colorName;
    return color;
}

+ (UIImage *)themeImage:(NSString *)imageName {
    BEEAppearanceManager *manager = [BEEAppearanceManager sharedManager];
    NSString *value = manager.themeConfigs[manager.currentThemeName][@"image"][imageName];
    UIImage *image = [UIImage imageNamed:value];
    image.imageName = imageName;
    return image;
}


#pragma mark - private methods

- (void)refreshTargetObject:(id)object {
    if ([object isKindOfClass:[UIView class]]) {
        [(UIView *)object refreshAppearance];
    }
    if ([object isKindOfClass:[NSObject class]]) {
        NSObject *obj = object;
        !obj.themeDidChange ?: obj.themeDidChange(self.currentThemeName, obj);
    }
}

- (void)addTrackedWithObject:(id)object {
    [self.trackedHashTable addObject:object];
}

#pragma mark - debug

- (NSString *)description {
    return [NSString stringWithFormat:@"~~~当前主题配置%@", self.themeConfigs];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"~~~当前主题配置%@\n所有存在控件~~~%@", self.themeConfigs, self.trackedHashTable];
}

@end
