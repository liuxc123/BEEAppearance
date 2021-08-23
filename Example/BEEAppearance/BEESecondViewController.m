//
//  BEESecondViewController.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEESecondViewController.h"
#import "BEEAppearance.h"
#import "ThemeConstant.h"

@interface BEESecondViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) NSUInteger limitCount;

@end

@implementation BEESecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Second";
    self.view.backgroundColor = BEEAppearanceColor(theme_backgroundColor);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([[BEEAppearanceManager sharedManager].currentTheme isEqualToString:theme_style_dark]) {
        [[BEEAppearanceManager sharedManager] changeTheme:theme_style_default];
    } else {
        [[BEEAppearanceManager sharedManager] changeTheme:theme_style_dark];
    }
}

@end
