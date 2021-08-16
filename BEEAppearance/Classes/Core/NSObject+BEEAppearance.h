//
//  NSObject+BEEAppearance.h
//  BEEAppearance
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BEEAppearance)

/// APP主题发生改变时回调。
@property (nonatomic, copy) void(^themeDidChange)(NSString *themeName, id bindView);

@end

NS_ASSUME_NONNULL_END
