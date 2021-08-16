//
//  BEEAppDelegate.m
//  BEEAppearance
//
//  Created by liuxc123 on 08/12/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

#import "BEEAppDelegate.h"
#import <BEEAppearance/BEEAppearance.h>

@implementation BEEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setupTheme];
    return YES;
}

- (void)setupTheme {
    
    NSDictionary *defaultThemeConfig = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"theme_default" ofType:@"plist"]];
    [[BEEAppearanceManager sharedManager] addTheme:defaultThemeConfig themeName:@"default"];
    
    NSDictionary *darkThemeConfig = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"theme_dark" ofType:@"plist"]];
    [[BEEAppearanceManager sharedManager] addTheme:darkThemeConfig themeName:@"dark"];
    
    [BEEAppearanceManager defaultTheme:@"default"];
}

@end
