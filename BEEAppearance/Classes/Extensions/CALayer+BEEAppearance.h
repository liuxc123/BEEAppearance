//
//  CALayer+BEEAppearance.h
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (BEEAppearance)

@property (nonatomic, nullable) UIColor *borderThemeColor;

@property (nonatomic, nullable) UIColor *backgroundThemeColor;

@property (nonatomic, nullable) UIColor *shadowThemeColor;

@property (nonatomic, nullable) UIImage *contentImage;

- (void)refreshAppearance;

@end

NS_ASSUME_NONNULL_END
