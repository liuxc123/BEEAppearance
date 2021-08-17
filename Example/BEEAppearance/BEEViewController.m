//
//  BEEViewController.m
//  BEEAppearance
//
//  Created by liuxc123 on 08/12/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

#import "BEEViewController.h"
#import "BEEAppearance.h"
#import "BEESecondViewController.h"
#import "ThemeConstant.h"

@interface BEEViewController () <UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *scrollView;

@end

@implementation BEEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    [self setupUI];
    
    [self setupNotification];
}

- (void)setupNavigationBar {
    self.title = @"Main";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: BEEAppearanceColor(@"textLabel1")};
    self.navigationController.navigationBar.tintColor = BEEAppearanceColor(@"textLabel1");
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"添加主题" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.navigationController.navigationBar.themeDidChange = ^(NSString * _Nonnull themeName, id  _Nonnull bindView) {
        UINavigationBar *navigationBar = bindView;
        if ([themeName isEqualToString: theme_style_dark]) {
            navigationBar.barStyle = UIBarStyleBlack;
        } else {
            navigationBar.barStyle = UIBarStyleDefault;
        }
    };
    self.navigationController.navigationBar.themeDidChange([BEEAppearanceManager sharedManager].currentTheme, self.navigationController.navigationBar);
}

- (void)setupUI {
    CGFloat centerX = CGRectGetWidth(self.view.frame) / 2;
    
    self.view.backgroundColor = BEEAppearanceColor(@"backgroundColor");
    
    // 滑动视图
    
    _scrollView = [[UIScrollView alloc] init];
    
    _scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 49);
    
    _scrollView.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    
    [self.scrollView addGestureRecognizer:tap];
    
    self.scrollView.backgroundColor = BEEAppearanceColor(@"backgroundColor");

    
    // view
    
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(0, 10, 120, 100);
    
    view.center = CGPointMake(centerX, view.center.y);
    
    view.clipsToBounds = YES;
    
    view.layer.borderWidth = 1.5f;
    
    view.layer.cornerRadius = 5.0f;
    
    [self.scrollView addSubview:view];
    
    view.backgroundColor = BEEAppearanceColor(@"backgroundColor");
    view.layer.borderColor = BEEAppearanceCGColor(@"textLabel3");
    
    // button
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(0, 180, 200, 40.0f);
    
    button.center = CGPointMake(centerX, button.center.y);
    
    [button setTitle:@"这是一个按钮" forState:UIControlStateNormal];
    
    [button setTitle:@"点击了这个按钮" forState:UIControlStateHighlighted];
    
    [button setTitle:@"选择了这个按钮" forState:UIControlStateSelected];
    
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        
    [button.layer setBorderWidth:0.5f];
    
    [button.layer setCornerRadius:5.0f];
    
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:button];
    
    [button setTitleColor:BEEAppearanceColor(@"textLabel1") forState:UIControlStateNormal];
    [button setTitleColor:BEEAppearanceColor(@"textLabel3") forState:UIControlStateDisabled];

    
    // imageView
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.frame = CGRectMake(0, 240, 120, 120);
    
    imageView.center = CGPointMake(centerX, imageView.center.y);
    
    [self.scrollView addSubview:imageView];
    
    imageView.image = BEEAppearanceImage(@"car");
    
    
    // slider
    
    UISlider *slider = [[UISlider alloc] init];
    
    slider.frame = CGRectMake(0, 380, 200, 40.0f);
    
    slider.center = CGPointMake(centerX, slider.center.y);
    
    slider.value = 0.4f;
    
    [self.scrollView addSubview:slider];
    
    [slider setMinimumTrackTintColor:BEEAppearanceColor(@"textLabel1")];
    
    
    // switch
    
    UISwitch *switchItem = [[UISwitch alloc] initWithFrame:CGRectMake(0, 440, 120, 40.0f)];
    
    switchItem.center = CGPointMake(centerX, switchItem.center.y);
    
    [self.scrollView addSubview:switchItem];
    
    switchItem.tintColor = BEEAppearanceColor(@"textLabel2");
    
    // textfield
    
    UITextField *textfield = [[UITextField alloc] init];
    
    textfield.frame = CGRectMake(0, 500, 200, 40.0f);
    
    textfield.center = CGPointMake(centerX, textfield.center.y);
    
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    
    textfield.placeholder = @"这是一个输入框";
    
    [self.scrollView addSubview:textfield];
    
    textfield.layer.cornerRadius = 10;
    textfield.layer.borderWidth = 1.0;
    textfield.layer.borderColor = BEEAppearanceCGColor(@"textLabel3");
    textfield.backgroundColor = BEEAppearanceColor(@"backgroundColor");
    textfield.textColor = BEEAppearanceColor(@"textLabel1");
    textfield.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"这是一个输入框" attributes:@{NSForegroundColorAttributeName: BEEAppearanceColor(@"textLabel3")}];

    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 560)];
}

- (void)setupNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:ThemeDidChangeNotification object:nil];
}

#pragma mark - 右点击事件

- (void)rightItemAction{
    
    [UIView animateWithDuration:0.27 animations:^{
        if ([[BEEAppearanceManager sharedManager].currentTheme isEqualToString: theme_style_default]) {
            [[BEEAppearanceManager sharedManager] changeTheme:theme_style_dark];
        } else {
            [[BEEAppearanceManager sharedManager] changeTheme:theme_style_default];
        }
    }];
}

- (void)clickAction {
    BEESecondViewController *vc = [BEESecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 单击手势事件

- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - NSNotification

- (void)themeDidChangeNotification:(NSNotification *)notification {
    NSLog(@"currentTheme:%@", notification.object);
    NSLog(@"%@", [BEEAppearanceManager sharedManager].description);
}

@end

