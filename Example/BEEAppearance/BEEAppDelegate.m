//
//  BEEAppDelegate.m
//  BEEAppearance
//
//  Created by liuxc123 on 08/12/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

#import "BEEAppDelegate.h"
#import <BEEAppearance/BEEAppearance.h>
#import "ThemeConstant.h"
#import "BEEMainWindow.h"
#import "BEEViewController.h"

@implementation BEEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 设置主题
    [self setupTheme];
    
    // 初始化window

    BEEMainWindow *window = [[BEEMainWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    window.fromSystemTheme = NO;
    
    window.backgroundColor = [UIColor whiteColor];
    
    [window makeKeyAndVisible];
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [BEEViewController new]];
    
    self.window = window;
        
    return YES;
}

- (void)setupTheme {
    
    NSDictionary *defaultThemeConfig = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"theme_default" ofType:@"plist"]];
    [[BEEAppearanceManager sharedManager] addTheme:defaultThemeConfig themeName: theme_style_default];

    NSDictionary *darkThemeConfig = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"theme_dark" ofType:@"plist"]];
    [[BEEAppearanceManager sharedManager] addTheme:darkThemeConfig themeName: theme_style_dark];
}

@end
