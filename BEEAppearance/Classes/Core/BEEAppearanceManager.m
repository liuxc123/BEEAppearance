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

static NSString * const BEEAppearanceAllTheme = @"BEEAppearanceAllTheme";
static NSString * const BEEAppearanceCurrentTheme = @"BEEAppearanceCurrentTheme";
static NSString * const BEEAppearanceConfigInfo = @"BEEAppearanceConfigInfo";

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

@property (nonatomic, strong, readwrite) NSString *currentTheme;
@property (nonatomic, strong, readwrite) NSMutableArray *allTheme;
@property (nonatomic, strong, readwrite) NSMutableDictionary *configInfo;
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
        self.currentTheme = [[NSUserDefaults standardUserDefaults] objectForKey:BEEAppearanceCurrentTheme] ?: @"";
    }
    return self;
}

#pragma mark - public methods

- (void)defaultTheme:(NSString *)themeName {
    
    NSAssert([[BEEAppearanceManager sharedManager].configInfo.allKeys containsObject:themeName], @"所启用的主题不存在 - 请检查是否添加了该%@主题的设置" , themeName);
    
    if (!themeName) { return; }
    
    self.currentTheme = themeName;
}

- (void)addTheme:(NSDictionary<NSString*, NSDictionary<NSString*, NSString*>*> *)config themeName:(NSString *)name {
    
    if (!name) { return; }
    
    if (!config) { return; }

    [self.configInfo setValue:config forKey:name];
    
    [self saveConfigInfo];
    
    [BEEAppearanceManager addThemeToAllThemes:name];
}

- (void)removeTheme:(NSString *)themeName {
    
    if (!themeName) { return; }
    
    [self.configInfo removeObjectForKey:themeName];
    
    [self saveConfigInfo];
    
    [BEEAppearanceManager removeThemeToAllThemes:themeName];
}

- (void)changeTheme:(NSString *)themeName {
    
    NSAssert([[BEEAppearanceManager sharedManager].configInfo.allKeys containsObject:themeName], @"所启用的主题不存在 - 请检查是否添加了该%@主题的设置" , themeName);
    
    if (!themeName) { return; }

    self.currentTheme = themeName;
    
    __weak typeof(self) weakSelf = self;
    [self.trackedHashTable.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf refreshTargetObject:obj];
    }];
    
    /// 发送主题已改变通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeDidChangeNotification object:[BEEAppearanceManager sharedManager].currentTheme];
}

+ (NSDictionary *)themeConfig:(NSString *)themeName {
    BEEAppearanceManager *manager = [BEEAppearanceManager sharedManager];
    return manager.configInfo[themeName];
}

+ (UIColor *)themeColor:(NSString *)colorName {
    BEEAppearanceManager *manager = [BEEAppearanceManager sharedManager];
    NSString *value = manager.configInfo[manager.currentTheme][@"color"][colorName];
    UIColor *color = [UIColor colorWithHexString:value] ?: [UIColor clearColor];
    color.colorName = colorName;
    return color;
}

+ (UIImage *)themeImage:(NSString *)imageName {
    BEEAppearanceManager *manager = [BEEAppearanceManager sharedManager];
    NSString *value = manager.configInfo[manager.currentTheme][@"image"][imageName];
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
        !obj.themeDidChange ?: obj.themeDidChange(self.currentTheme, obj);
    }
}

- (void)addTrackedWithObject:(id)object {
    
    [self.trackedHashTable addObject:object];
}

- (void)setCurrentTheme:(NSString *)currentTheme {
    _currentTheme = currentTheme;
    
    [[NSUserDefaults standardUserDefaults] setObject:currentTheme forKey:BEEAppearanceCurrentTheme];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveConfigInfo{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.configInfo forKey:BEEAppearanceConfigInfo];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)addThemeToAllThemes:(NSString *)themeName{
    
    if (![[BEEAppearanceManager sharedManager].allTheme containsObject:themeName]) {
        
        [[BEEAppearanceManager sharedManager].allTheme addObject:themeName];
        
        [[NSUserDefaults standardUserDefaults] setObject:[BEEAppearanceManager sharedManager].allTheme forKey:BEEAppearanceAllTheme];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

+ (void)removeThemeToAllThemes:(NSString *)themeName{
    
    if ([[BEEAppearanceManager sharedManager].allTheme containsObject:themeName]) {
        
        [[BEEAppearanceManager sharedManager].allTheme removeObject:themeName];
        
        [[NSUserDefaults standardUserDefaults] setObject:[BEEAppearanceManager sharedManager].allTheme forKey:BEEAppearanceAllTheme];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

#pragma mark - Lazy Loading

- (NSHashTable *)trackedHashTable {
    
    if (!_trackedHashTable) {
        _trackedHashTable = [NSHashTable weakObjectsHashTable];
    }
    
    return _trackedHashTable;
}

- (NSMutableArray *)allTheme {
    
    if (!_allTheme) {
        _allTheme = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:BEEAppearanceAllTheme]];
    }
    
    return _allTheme;
}

- (NSMutableDictionary *)configInfo{
    
    if (!_configInfo) {
        _configInfo = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:BEEAppearanceConfigInfo]];
    }
    
    return _configInfo;
}

#pragma mark - debug

- (NSString *)description {
    return [NSString stringWithFormat:@"~~~已配置主题：%@\n~~~~主题配置%@", self.allTheme, self.configInfo];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"~~~已配置主题：%@\n~~~所有主题配置%@\n所有存在控件~~~%@", self.allTheme, self.configInfo, self.trackedHashTable];
}

@end
