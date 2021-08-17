//
//  BEESecondViewController.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEESecondViewController.h"
#import "BEEAppearance.h"
#import "BEEAppearanceDefine.h"

@interface BEESecondViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) NSUInteger limitCount;

@end

@implementation BEESecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Second";
    self.view.backgroundColor = BEEAppearanceColor(@"backgroundColor");
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.frame = CGRectMake(0, 88, self.view.frame.size.width, 200);
    textView.font = [UIFont systemFontOfSize:17];
    self.textView = textView;
    [self.view addSubview:textView];
    
    textView.backgroundColor = BEEAppearanceColor(@"backgroundColor");
    textView.textColor = BEEAppearanceColor(@"textLabel1");
}

@end
