//
//  BEEAppearanceManager.h
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/12.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern UIColor* BEEAppearanceColor(NSString *colorName);
extern CGColorRef BEEAppearanceCGColor(NSString *colorName);
extern UIImage* BEEAppearanceImage(NSString *imageName);

static NSString * const ThemeDidChangeNotification = @"ThemeDidChangeNotification";

@interface BEEAppearanceManager : NSObject

@property (nonatomic, strong, readonly) NSString *currentThemeName;
@property (nonatomic, strong, readonly) NSMutableDictionary *themeConfigs;
@property (nonatomic, strong, readonly) NSHashTable *trackedHashTable;

+ (instancetype)sharedManager;
+ (void)defaultTheme:(NSString *)themeName;

- (void)addTrackedWithObject:(id)object;

- (void)addTheme:(NSDictionary<NSString*, NSDictionary<NSString*, NSString*>*> *)config themeName:(NSString *)name;
- (void)changeTheme:(NSString *)themeName;

+ (NSDictionary *)themeConfig:(NSString *)themeName;
+ (UIColor *)themeColor:(NSString *)colorName;
+ (UIImage *)themeImage:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
