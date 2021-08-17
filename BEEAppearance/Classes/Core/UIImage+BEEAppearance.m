//
//  UIImage+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "UIImage+BEEAppearance.h"
#import "BEEAppearanceManager.h"
#import <objc/runtime.h>

@implementation UIImage (BEEAppearance)

- (void)setImageName:(NSString *)imageName {
    objc_setAssociatedObject(self, @selector(imageName), imageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)imageName {
    return objc_getAssociatedObject(self,  @selector(imageName));
}

- (void)setThemeProvider:(BEEAppearanceImageThemeProvider)themeProvider {
    objc_setAssociatedObject(self, @selector(themeProvider), themeProvider, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BEEAppearanceImageThemeProvider)themeProvider {
    return objc_getAssociatedObject(self,  @selector(themeProvider));
}

+ (UIImage *)imageWithThemeProvider:(BEEAppearanceImageThemeProvider)themeProvider {
    UIImage *tempImage = themeProvider([BEEAppearanceManager sharedManager].currentTheme);
    tempImage.themeProvider = themeProvider;
    return tempImage;
}

- (UIImage *)refreshAppearance {
    UIImage *tempImage = self;
    
    if (self.imageName) {
        tempImage = [BEEAppearanceManager themeImage:self.imageName];
    }
    
    if (self.themeProvider) {
        BEEAppearanceImageThemeProvider provider = self.themeProvider;
        tempImage = provider([[BEEAppearanceManager sharedManager] currentTheme]);
        tempImage.themeProvider = provider;
    }

    return tempImage;
}

- (BOOL)isTheme {
    return self.imageName || self.themeProvider;
}

@end
