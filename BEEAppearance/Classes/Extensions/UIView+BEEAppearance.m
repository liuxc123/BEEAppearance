//
//  UIView+BEEAppearance.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "UIView+BEEAppearance.h"
#import "BEEAppearanceManager.h"
#import "UIColor+BEEAppearance.h"
#import "UIImage+BEEAppearance.h"
#import "NSObject+BEEAppearanceInteral.h"
#import "NSMutableAttributedString+BEEAppearance.h"
#import "NSMutableDictionary+BEEAppearance.h"
#import "CALayer+BEEAppearance.h"
#import <objc/runtime.h>

@implementation UIView (BEEAppearance)

+ (void)load {
    self.methodExchange(@selector(didMoveToSuperview), @selector(bee_didMoveToSuperview));

    // 交换backgroundColor的set和get方法(因为backgroundColor有copy属性，导致每次赋值地址都发生改变)。
    self.methodExchange(@selector(setBackgroundColor:), @selector(setBee_backgroundColor:));
    self.methodExchange(@selector(backgroundColor), @selector(bee_backgroundColor));
}

- (void)bee_didMoveToSuperview {
    [self bee_didMoveToSuperview];
    [[BEEAppearanceManager sharedManager] addTrackedWithObject:self];
}

- (void)setBee_backgroundColor:(UIColor *)bee_backgroundColor {
    objc_setAssociatedObject(self, @selector(bee_backgroundColor), bee_backgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBee_backgroundColor:bee_backgroundColor];
}

- (UIColor *)bee_backgroundColor {
    return objc_getAssociatedObject(self, @selector(bee_backgroundColor));
}

#pragma mark - refresh

- (void)refreshAppearance {
    
    [self.layer refreshAppearance];
    
    if (self.backgroundColor.isTheme) {
        self.backgroundColor = [self.backgroundColor refreshAppearance];
    }
    
    if (self.tintColor.isTheme) {
        self.tintColor = [self.tintColor refreshAppearance];
    }
    
    if ([self isKindOfClass:UILabel.class]) {
        [self refreshUILabel];
    }
    
    if ([self isKindOfClass:UIButton.class]) {
        [self refreshUIButton];
    }
    
    if ([self isKindOfClass:UIImageView.class]) {
        [self refreshUIImageView];
    }
    
    if ([self isKindOfClass:UITextField.class]) {
        [self refreshUITextField];
    }
    
    if ([self isKindOfClass:UITextView.class]) {
        [self refreshUITextView];
    }
    
    if ([self isKindOfClass:UITableView.class]) {
        [self refreshUITableView];
    }
    
    if ([self isKindOfClass:UIActivityIndicatorView.class]) {
        [self refreshUIActivityIndicatorView];
    }
    
    if ([self isKindOfClass:UIProgressView.class]) {
        [self refreshUIProgressView];
    }
    
    if ([self isKindOfClass:UIPageControl.class]) {
        [self refreshUIPageControl];
    }
    
    if ([self isKindOfClass:UISwitch.class]) {
        [self refreshUISwitch];
    }
    
    if ([self isKindOfClass:UISlider.class]) {
        [self refreshUISlider];
    }
    
    if ([self isKindOfClass:UIStepper.class]) {
        [self refreshUIStepper];
    }
    
    if ([self isKindOfClass:UIRefreshControl.class]) {
        [self refreshUIRefreshControl];
    }
    
    if ([self isKindOfClass:UISegmentedControl.class]) {
        [self refreshUISegmentedControl];
    }
    
    if ([self isKindOfClass:UINavigationBar.class]) {
        [self refreshUINavigationBar];
    }
    
    if ([self isKindOfClass:UIToolbar.class]) {
        [self refreshUIToolBar];
    }
    
    if ([self isKindOfClass:UITabBar.class]) {
        [self refreshUITabBar];
    }
    
    if ([self isKindOfClass:UISearchBar.class]) {
        [self refreshUISearchBar];
    }
}


- (void)refreshUILabel {
    UILabel *label = (UILabel *)self;
    
    if (label.highlightedTextColor.isTheme) {
        label.highlightedTextColor = [label.highlightedTextColor refreshAppearance];
    }
    
    NSMutableAttributedString *attr = [label.attributedText mutableCopy];
    [attr refreshAppearance];
    label.attributedText = attr;
}

- (void)refreshUIButton {
    UIButton *button = (UIButton *)self;
    
    [button forinUIControlState:^(UIControlState state, UIButton * _Nonnull obj) {
        // 刷新titleColor
        UIColor *titleColor = [obj titleColorForState:state];
        if (titleColor.isTheme) {
            [obj setTitleColor:[titleColor refreshAppearance] forState:state];
        }

        // 刷新shadowColor
        UIColor *shadowColor = [obj titleShadowColorForState:state];
        if (shadowColor.isTheme) {
            [obj setTitleShadowColor:[shadowColor refreshAppearance] forState:state];
        }

        // 刷新image
        UIImage *image = [obj imageForState:state];
        if (image.isTheme) {
            [obj setImage:[image refreshAppearance] forState:state];
        }

        // 刷新backgroundImage
        UIImage *backgroundImage = [obj backgroundImageForState:state];
        if (backgroundImage.isTheme) {
            [obj setBackgroundImage:[backgroundImage refreshAppearance] forState:state];
        }
        
        // 刷新富文本
        NSAttributedString *attr = [obj attributedTitleForState:state];
        NSMutableAttributedString *mutable_attr = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
        [mutable_attr refreshAppearance];
        [obj setAttributedTitle:mutable_attr forState:state];
    }];
}

- (void)refreshUIImageView {
    UIImageView *imageView = (UIImageView *)self;
    
    if (imageView.image.isTheme) {
        imageView.image = [imageView.image refreshAppearance];
    }
        
    if (imageView.highlightedImage.isTheme) {
        imageView.highlightedImage = [imageView.highlightedImage refreshAppearance];
    }
}

- (void)refreshUITextField {
    UITextField *textField = (UITextField *)self;
    
    NSMutableAttributedString *attr = [textField.attributedText mutableCopy];
    [attr refreshAppearance];
    textField.attributedText = attr;
    
    NSMutableAttributedString *placeAttr = [textField.attributedPlaceholder mutableCopy];
    [placeAttr refreshAppearance];
    textField.attributedPlaceholder = placeAttr;
    
    NSMutableDictionary *typingDict = [textField.typingAttributes mutableCopy];
    [typingDict refreshAppearance];
    textField.typingAttributes = typingDict;
    
    if (textField.background.isTheme) {
        textField.background = [textField.background refreshAppearance];
    }
    
    if (textField.disabledBackground.isTheme) {
        textField.disabledBackground = [textField.disabledBackground refreshAppearance];
    }
    
    if (textField.inputView) {
        [textField.inputView refreshAppearance];
    }
    
    if (textField.inputAccessoryView) {
        [textField.inputAccessoryView refreshAppearance];
    }
    
    if (textField.textColor.isTheme) {
        textField.textColor = [textField.textColor refreshAppearance];
    }
}

- (void)refreshUITextView {
    UITextView *textView = (UITextView *)self;
    
    NSMutableAttributedString *attr = [textView.attributedText mutableCopy];
    [attr refreshAppearance];
    textView.attributedText = attr;
    
    NSMutableDictionary *typingDict = [textView.typingAttributes mutableCopy];
    [typingDict refreshAppearance];
    textView.typingAttributes = typingDict;
    
    NSMutableDictionary *linkDict = [textView.linkTextAttributes mutableCopy];
    [linkDict refreshAppearance];
    textView.linkTextAttributes = linkDict;
    
    if (textView.inputView) {
        [textView.inputView refreshAppearance];
    }
    
    if (textView.inputAccessoryView) {
        [textView.inputAccessoryView refreshAppearance];
    }
}

- (void)refreshUITableView {
    UITableView *tableView = (UITableView *)self;
    
    if (tableView.sectionIndexColor.isTheme) {
        tableView.sectionIndexColor = [tableView.sectionIndexColor refreshAppearance];
    }
    
    if (tableView.sectionIndexBackgroundColor.isTheme) {
        tableView.sectionIndexBackgroundColor = [tableView.sectionIndexBackgroundColor refreshAppearance];
    }
    
    if (tableView.sectionIndexTrackingBackgroundColor.isTheme) {
        tableView.sectionIndexTrackingBackgroundColor = [tableView.sectionIndexTrackingBackgroundColor refreshAppearance];
    }
}

- (void)refreshUIActivityIndicatorView {
    UIActivityIndicatorView *view = (UIActivityIndicatorView *)self;
    
    if (view.color.isTheme) {
        view.color = [view.color refreshAppearance];
    }
}

- (void)refreshUIProgressView {
    UIProgressView *progressView = (UIProgressView *)self;
    
    if (progressView.progressTintColor.isTheme) {
        progressView.progressTintColor = [progressView.progressTintColor refreshAppearance];
    }
    
    if (progressView.trackTintColor.isTheme) {
        progressView.trackTintColor = [progressView.trackTintColor refreshAppearance];
    }
    
    if (progressView.progressImage.isTheme) {
        progressView.progressImage = [progressView.progressImage refreshAppearance];
    }
    
    if (progressView.trackImage.isTheme) {
        progressView.trackImage = [progressView.trackImage refreshAppearance];
    }
}

- (void)refreshUIPageControl {
    UIPageControl *pageControl = (UIPageControl *)self;
    
    if (pageControl.pageIndicatorTintColor.isTheme) {
        pageControl.pageIndicatorTintColor = [pageControl.pageIndicatorTintColor refreshAppearance];
    }
    
    if (pageControl.currentPageIndicatorTintColor.isTheme) {
        pageControl.currentPageIndicatorTintColor = [pageControl.currentPageIndicatorTintColor refreshAppearance];
    }
    
    if (@available(iOS 14.0, *)) {
        if (pageControl.preferredIndicatorImage.isTheme) {
            pageControl.preferredIndicatorImage = [pageControl.preferredIndicatorImage refreshAppearance];
        }
        for (NSInteger i = 0; i < pageControl.numberOfPages; i++) {
            UIImage *image = [pageControl indicatorImageForPage:i];
            if (image.isTheme) {
                image = [image refreshAppearance];
                [pageControl setIndicatorImage:image forPage:i];
            }
        }
    }
}

- (void)refreshUISwitch {
    UISwitch *t_switch = (UISwitch *)self;
    
    if (t_switch.onTintColor.isTheme) {
        t_switch.onTintColor = [t_switch.onTintColor refreshAppearance];
    }
    
    if (t_switch.thumbTintColor.isTheme) {
        t_switch.thumbTintColor = [t_switch.thumbTintColor refreshAppearance];
    }
    
    if (t_switch.onImage.isTheme) {
        t_switch.onImage = [t_switch.onImage refreshAppearance];
    }
    
    if (t_switch.offImage.isTheme) {
        t_switch.offImage = [t_switch.offImage refreshAppearance];
    }
}

- (void)refreshUISlider {
    UISlider *slider = (UISlider *)self;
    
    if (slider.minimumValueImage.isTheme) {
        slider.minimumValueImage = [slider.minimumValueImage refreshAppearance];
    }
    
    if (slider.maximumValueImage.isTheme) {
        slider.maximumValueImage = [slider.maximumValueImage refreshAppearance];
    }
    
    if (slider.minimumTrackTintColor.isTheme) {
        slider.minimumTrackTintColor = [slider.minimumTrackTintColor refreshAppearance];
    }
    
    if (slider.maximumTrackTintColor.isTheme) {
        slider.maximumTrackTintColor = [slider.maximumTrackTintColor refreshAppearance];
    }
    
    if (slider.thumbTintColor.isTheme) {
        slider.thumbTintColor = [slider.thumbTintColor refreshAppearance];
    }
    
    [slider forinUIControlState:^(UIControlState state, UISlider * _Nonnull obj) {
        UIImage *thumbImage = [obj thumbImageForState:state];
        if (thumbImage.isTheme) {
            [obj setThumbImage:[thumbImage refreshAppearance] forState:state];
        }
        
        UIImage *minimumImage = [obj minimumTrackImageForState:state];
        if (minimumImage.isTheme) {
            [obj setMinimumTrackImage:[minimumImage refreshAppearance]  forState:state];
        }
        
        UIImage *maximumImage = [obj maximumTrackImageForState:state];
        if (maximumImage.isTheme) {
            [obj setMaximumTrackImage:[maximumImage refreshAppearance] forState:state];
        }
    }];
}

- (void)refreshUIStepper {
    UIStepper *stepper = (UIStepper *)self;
    
    [stepper forinUIControlState:^(UIControlState state, UIStepper * _Nonnull obj) {
        UIImage *backgroundImage = [obj backgroundImageForState:state];
        if (backgroundImage.isTheme) {
            [obj setBackgroundImage:[backgroundImage refreshAppearance] forState:state];
        }
        
        UIImage *incrementImage = [obj incrementImageForState:state];
        if (incrementImage.isTheme) {
            [obj setIncrementImage:[incrementImage refreshAppearance] forState:state];
        }
        
        UIImage *decrementImage = [obj decrementImageForState:state];
        if (decrementImage.isTheme) {
            [obj setDecrementImage:[decrementImage refreshAppearance] forState:state];
        }
        
        [obj forinUIControlState:^(UIControlState state1, UIStepper * _Nonnull obj1) {
            UIImage *dividerImage = [obj1 dividerImageForLeftSegmentState:state rightSegmentState:state1];
            if (dividerImage.isTheme) {
                [obj1 setDividerImage:[dividerImage refreshAppearance] forLeftSegmentState:state rightSegmentState:state1];
            }
        }];
    }];
}

- (void)refreshUIRefreshControl {
    UIRefreshControl *refreshControl = (UIRefreshControl *)self;
    
    NSMutableAttributedString *mutable_attr = [[NSMutableAttributedString alloc] initWithAttributedString:refreshControl.attributedTitle];
    [mutable_attr refreshAppearance];
    refreshControl.attributedTitle = mutable_attr;
}

- (void)refreshUISegmentedControl {
    UISegmentedControl *segmented = (UISegmentedControl *)self;
    
    if (@available(iOS 13.0, *)) {
        if (segmented.selectedSegmentTintColor.isTheme) {
            segmented.selectedSegmentTintColor = [segmented.selectedSegmentTintColor refreshAppearance];
        }
    }
    
    for (NSInteger i = 0; i < segmented.numberOfSegments; i++) {
        UIImage *image = [segmented imageForSegmentAtIndex:i];
        if (image.isTheme) {
            [segmented setImage:[image refreshAppearance] forSegmentAtIndex:i];
        }
    }
    
    [segmented forinUIControlState:^(UIControlState state, UISegmentedControl * _Nonnull obj) {
        NSMutableDictionary<NSAttributedStringKey, id> *dict = [[obj titleTextAttributesForState:state] mutableCopy];
        [dict refreshAppearance];
        [obj setTitleTextAttributes:dict forState:state];
                
        [obj forinUIBarMetrics:^(UIBarMetrics metrics, UISegmentedControl * _Nonnull obj1) {
            UIImage *backgroundImage = [obj1 backgroundImageForState:state barMetrics:metrics];
            if (backgroundImage.isTheme) {
                [obj1 setBackgroundImage:[backgroundImage refreshAppearance] forState:state barMetrics:metrics];
            }
            
            [obj1 forinUIControlState:^(UIControlState state1, UISegmentedControl * _Nonnull obj2) {
                UIImage *dividerImage = [obj2 dividerImageForLeftSegmentState:state rightSegmentState:state1 barMetrics:metrics];
                if (dividerImage.isTheme) {
                    [obj2 setDividerImage:dividerImage.refreshAppearance forLeftSegmentState:state rightSegmentState:state1 barMetrics:metrics];
                }
            }];
        }];
    }];
}

- (void)refreshUINavigationBar {
    UINavigationBar *navigationBar = (UINavigationBar *)self;
    
    UIColor *barTintColor = navigationBar.barTintColor;
    if (barTintColor.isTheme) {
        navigationBar.barTintColor = [barTintColor refreshAppearance];
    }
    
    UIImage *shadowImage = navigationBar.shadowImage;
    if (shadowImage.isTheme) {
        navigationBar.shadowImage = [shadowImage refreshAppearance];
    }
    
    UIImage *backIndicatorImage = navigationBar.backIndicatorImage;
    if (backIndicatorImage.isTheme) {
        navigationBar.backIndicatorImage = [backIndicatorImage refreshAppearance];
    }
    
    UIImage *backIndicatorTransitionMaskImage = navigationBar.backIndicatorTransitionMaskImage;
    if (backIndicatorTransitionMaskImage.isTheme) {
        navigationBar.backIndicatorTransitionMaskImage = [backIndicatorTransitionMaskImage refreshAppearance];
    }
    
    NSMutableDictionary *titleTextAttributes = [navigationBar.titleTextAttributes mutableCopy];
    [titleTextAttributes refreshAppearance];
    navigationBar.titleTextAttributes = titleTextAttributes;
    
    if (@available(iOS 11.0, *)) {
        NSMutableDictionary *largeTitleTextAttributes = [navigationBar.largeTitleTextAttributes mutableCopy];
        [largeTitleTextAttributes refreshAppearance];
        navigationBar.largeTitleTextAttributes = largeTitleTextAttributes;
    }
    
    [navigationBar forinUIBarPosition:^(UIBarPosition position, UINavigationBar * _Nonnull obj) {
        [obj forinUIBarMetrics:^(UIBarMetrics metrics, UINavigationBar * _Nonnull obj1) {
            UIImage *image = [navigationBar backgroundImageForBarPosition:position barMetrics:metrics];
            if (image.isTheme) {
                [obj1 setBackgroundImage:[image refreshAppearance] forBarPosition:position barMetrics:metrics];
            }
        }];
    }];
    
    for (UINavigationItem *item in navigationBar.items) {
        [self refreshUINavigationItem:item];
    }
}

- (void)refreshUINavigationItem:(UINavigationItem *)item {
    [item.titleView refreshAppearance];
    
    for (UIBarButtonItem *buttonItem in item.leftBarButtonItems) {
        [self refreshUIBarButtonItem:buttonItem];
    }
    
    for (UIBarButtonItem *buttonItem in item.rightBarButtonItems) {
        [self refreshUIBarButtonItem:buttonItem];
    }
    
    if (@available(iOS 11.0, *)) {
        UISearchController *searchController = item.searchController;
        if (searchController.searchBar) {
            [searchController.searchBar refreshAppearance];
        }
    }
}

- (void)refreshUIToolBar {
    UIToolbar *toolBar = (UIToolbar *)self;
    
    UIColor *barTintColor = toolBar.barTintColor;
    if (barTintColor.isTheme) {
        toolBar.barTintColor = [barTintColor refreshAppearance];
    }
    
    [toolBar forinUIBarPosition:^(UIBarPosition position, UIToolbar * _Nonnull obj) {
        UIImage *shadowImage = [obj shadowImageForToolbarPosition:position];
        if (shadowImage.isTheme) {
            [obj setShadowImage:[shadowImage refreshAppearance] forToolbarPosition:position];
        }
        
        [obj forinUIBarMetrics:^(UIBarMetrics metrics, UIToolbar * _Nonnull obj1) {
            UIImage *backgroundImage = [obj1 backgroundImageForToolbarPosition:position barMetrics:metrics];
            if (backgroundImage.isTheme) {
                [obj1 setBackgroundImage:[backgroundImage refreshAppearance] forToolbarPosition:position barMetrics:metrics];
            }
        }];
    }];
    
    for (UIBarButtonItem *item in toolBar.items) {
        [self refreshUIBarButtonItem:item];
    }
}


- (void)refreshUITabBar {
    UITabBar *tabBar = (UITabBar *)self;
    
    UIColor *barTintColor = tabBar.barTintColor;
    if (barTintColor.isTheme) {
        tabBar.barTintColor = [barTintColor refreshAppearance];
    }
    
    if (@available(iOS 10.0, *)) {
        UIColor *unselectedItemTintColor = tabBar.unselectedItemTintColor;
        if (unselectedItemTintColor.isTheme) {
            tabBar.unselectedItemTintColor = [unselectedItemTintColor refreshAppearance];
        }
    }
    
    UIImage *backgroundImage = tabBar.backgroundImage;
    if (backgroundImage.isTheme) {
        tabBar.backgroundImage = [backgroundImage refreshAppearance];
    }
    
    UIImage *selectionIndicatorImage = tabBar.selectionIndicatorImage;
    if (selectionIndicatorImage.isTheme) {
        tabBar.selectionIndicatorImage = [selectionIndicatorImage refreshAppearance];
    }
    
    UIImage *shadowImage = tabBar.shadowImage;
    if (shadowImage.isTheme) {
        tabBar.shadowImage = [shadowImage refreshAppearance];
    }
    
    for (UITabBarItem *item in tabBar.items) {
        [self refreshUITabBarItem:item];
    }
}

- (void)refreshUITabBarItem:(UITabBarItem *)item {
    if (@available(iOS 10.0, *)) {
        UIColor *badgeColor = item.badgeColor;
        if (badgeColor.isTheme) {
            item.badgeColor = [badgeColor refreshAppearance];
        }
    }
    
    UIImage *selectedImage = item.selectedImage;
    if (selectedImage.isTheme) {
        item.selectedImage = [selectedImage refreshAppearance];
    }
    
    [item forinUIControlState:^(UIControlState state, UITabBarItem * _Nonnull obj) {
        if (@available(iOS 10.0, *)) {
            NSMutableDictionary<NSAttributedStringKey, id> *t_dict = [[obj badgeTextAttributesForState:state] mutableCopy];
            [t_dict refreshAppearance];
            [obj setBadgeTextAttributes:t_dict forState:state];
        }
    }];
    
    [self refreshUIBarItem:item];
}

- (void)refreshUIBarButtonItem:(UIBarButtonItem *)item {
    [item.customView refreshAppearance];
    
    UIColor *tintColor = item.tintColor;
    if (tintColor.isTheme) {
        item.tintColor = [tintColor refreshAppearance];
    }
    
    [item forinUIControlState:^(UIControlState state, UIBarButtonItem * _Nonnull obj) {
        [obj forinUIBarMetrics:^(UIBarMetrics metrics, UIBarButtonItem * _Nonnull obj1) {
            UIImage *t_backButtonBackgroundImage = [obj1 backButtonBackgroundImageForState:state barMetrics:metrics];
            if (t_backButtonBackgroundImage.isTheme) {
                [obj1 setBackButtonBackgroundImage:[t_backButtonBackgroundImage refreshAppearance] forState:state barMetrics:metrics];
            }
            
            [obj1 forinUIBarButtonItemStyle:^(UIBarButtonItemStyle style, UIBarButtonItem * _Nonnull obj2) {
                UIImage *t_backgroundImage = [obj2 backgroundImageForState:state style:style barMetrics:metrics];
                if (t_backgroundImage.isTheme) {
                    [obj2 setBackgroundImage:[t_backgroundImage refreshAppearance] forState:state style:style barMetrics:metrics];
                }
            }];
        }];
    }];
    
    [self refreshUIBarItem:item];
}

- (void)refreshUIBarItem:(UIBarItem *)item {
    UIImage *t_image = item.image;
    if (t_image.isTheme) {
        item.image = [t_image refreshAppearance];
    }
    
    if (@available(iOS 11.0, *)) {
        UIImage *t_largeContentSizeImage = item.largeContentSizeImage;
        if (t_largeContentSizeImage.isTheme) {
            item.largeContentSizeImage = [t_largeContentSizeImage refreshAppearance];
        }
    }
    
    [item forinUIControlState:^(UIControlState state, UIBarButtonItem * _Nonnull obj) {
        NSMutableDictionary<NSAttributedStringKey, id> *t_attributes = [[obj titleTextAttributesForState:state] mutableCopy];
        [t_attributes refreshAppearance];
        [obj setTitleTextAttributes:t_attributes forState:state];
    }];
}


- (void)refreshUISearchBar {
    UISearchBar *searchBar = (UISearchBar *)self;

    UIView *inputAccessoryView = searchBar.inputAccessoryView;
    [inputAccessoryView refreshAppearance];

    UIColor *barTintColor = searchBar.barTintColor;
    if (barTintColor.isTheme) {
        searchBar.barTintColor = [barTintColor refreshAppearance];
    }

    UIImage *scopeBarBackgroundImage = searchBar.scopeBarBackgroundImage;
    if (scopeBarBackgroundImage.isTheme) {
        searchBar.scopeBarBackgroundImage = [scopeBarBackgroundImage refreshAppearance];
    }

    [searchBar forinUIBarPosition:^(UIBarPosition position, UISearchBar * _Nonnull obj) {
        [obj forinUIBarMetrics:^(UIBarMetrics metrics, UISearchBar * _Nonnull obj1) {
            UIImage *image = [obj1 backgroundImageForBarPosition:position barMetrics:metrics];
            if (image.isTheme) {
                [obj1 setBackgroundImage:[image refreshAppearance] forBarPosition:position barMetrics:metrics];
            }
        }];
    }];

    [searchBar forinUIControlState:^(UIControlState state, UISearchBar * _Nonnull obj) {
        UIImage *searchFieldBackgroundImage = [obj searchFieldBackgroundImageForState:state];
        if (searchFieldBackgroundImage.isTheme) {
            [obj setSearchFieldBackgroundImage:[searchFieldBackgroundImage refreshAppearance] forState:state];
        }

        UIImage *scopeBarButtonBackgroundImage = [obj scopeBarButtonBackgroundImageForState:state];
        if (scopeBarButtonBackgroundImage.isTheme) {
            [obj setScopeBarButtonBackgroundImage:[scopeBarButtonBackgroundImage refreshAppearance] forState:state];
        }

        NSMutableDictionary<NSAttributedStringKey, id> *attributes = [[obj scopeBarButtonTitleTextAttributesForState:state] mutableCopy];
        [attributes refreshAppearance];
        [obj setScopeBarButtonTitleTextAttributes:attributes forState:state];

        [obj forinUISearchBarIcon:^(UISearchBarIcon icon, UISearchBar * _Nonnull obj1) {
            UIImage *image = [obj1 imageForSearchBarIcon:icon state:state];
            if (image.isTheme) {
                [obj1 setImage:[image refreshAppearance] forSearchBarIcon:icon state:state];
            }
        }];

        [obj forinUIControlState:^(UIControlState state1, UISearchBar * _Nonnull obj1) {
            UIImage *image = [obj1 scopeBarButtonDividerImageForLeftSegmentState:state rightSegmentState:state1];
            if (image.isTheme) {
                [obj1 setScopeBarButtonDividerImage:[image refreshAppearance] forLeftSegmentState:state rightSegmentState:state1];
            }
        }];
    }];
}

@end
