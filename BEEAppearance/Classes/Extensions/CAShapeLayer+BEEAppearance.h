//
//  CAShapeLayer+BEEAppearance.h
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAShapeLayer (BEEAppearance)

@property (nonatomic, nullable) UIColor *fillThemeColor;

@property (nonatomic, nullable) UIColor *strokeThemeColor;

@end

NS_ASSUME_NONNULL_END
