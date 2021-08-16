//
//  UIImage+BEEAppearance.h
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UIImage *_Nullable(^BEEAppearanceImageThemeProvider)(NSString *themeName);

@interface UIImage (BEEAppearance)

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) BEEAppearanceImageThemeProvider themeProvider;

+ (UIImage *)imageWithThemeProvider:(BEEAppearanceImageThemeProvider)themeProvider;
- (UIImage *)refreshAppearance;
- (BOOL)isTheme;

@end

NS_ASSUME_NONNULL_END
