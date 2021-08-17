//
//  BEEMainWindow.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/17.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEEMainWindow.h"
#import "BEEAppearance.h"
#import "ThemeConstant.h"

@implementation BEEMainWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 是否跟随系统切换主题
        self.fromSystemTheme = YES;
        
        // 根据系统样式变化 重新启用相应的主题 以达到同步的效果
        if (@available(iOS 13.0, *)) {
            
            if (self.fromSystemTheme) {
                
                switch (self.traitCollection.userInterfaceStyle) {
                    case UIUserInterfaceStyleLight:
                        
                        [[BEEAppearanceManager sharedManager] defaultTheme:theme_style_default];
                        
                        break;
                        
                    case UIUserInterfaceStyleDark:
                        
                        [[BEEAppearanceManager sharedManager] defaultTheme: theme_style_dark];
                        
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    return self;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    // 根据系统样式变化 重新启用相应的主题 以达到同步的效果
    if (@available(iOS 13.0, *)) {
        
        if (self.fromSystemTheme) {
            
            switch (self.traitCollection.userInterfaceStyle) {
                case UIUserInterfaceStyleLight:
                    
                    [[BEEAppearanceManager sharedManager] changeTheme: theme_style_default];
                    
                    break;
                    
                case UIUserInterfaceStyleDark:
                    
                    [[BEEAppearanceManager sharedManager] changeTheme: theme_style_dark];
                    
                    break;
                    
                default:
                    break;
            }
        }
    }
}

@end
