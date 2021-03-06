//
//  NSObject+BEEAppearanceInteral.h
//  BEEAppearance
//
//  Created by mac on 2021/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BEEAppearanceInteral)

/// 交换2个方法的实现
+ (void (^) (SEL sel1, SEL sel2))methodExchange;


/// 遍历UIControlState所有类型并执行complete块。
- (void)forinUIControlState:(void (^)(UIControlState state, id obj))complete;


/// 遍历UIBarMetrics所有类型并执行complete块
- (void)forinUIBarMetrics:(void (^) (UIBarMetrics metrics, id obj))complete;


/// 遍历UIBarPosition所有类型并执行complete块
- (void)forinUIBarPosition:(void (^) (UIBarPosition position, id obj))complete;


/// 遍历UIBarButtonItemStyle所有类型并执行complete块
- (void)forinUIBarButtonItemStyle:(void (^) (UIBarButtonItemStyle style, id obj))complete;


/// 遍历UISearchBarIcon所有类型并执行complete块
- (void)forinUISearchBarIcon:(void (^) (UISearchBarIcon icon, id obj))complete;

@end

NS_ASSUME_NONNULL_END
