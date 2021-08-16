//
//  UIColor+BEEAppearance.h
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIColor *_Nullable(^BEEAppearanceColorThemeProvider)(NSString *themeName);

@interface UIColor (BEEAppearance)

@property (nonatomic, copy) NSString *colorName;
@property (nonatomic, copy) BEEAppearanceColorThemeProvider themeProvider;

+ (UIColor *)colorWithThemeProvider:(BEEAppearanceColorThemeProvider)themeProvider;
- (UIColor *)refreshAppearance;
- (BOOL)isTheme;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
