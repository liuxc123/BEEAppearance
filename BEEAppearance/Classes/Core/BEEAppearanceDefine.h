//
//  BEEAppearanceDefine.h
//  BEEAppearance
//
//  Created by mac on 2021/8/13.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#ifndef BEEAppearanceDefine_h
#define BEEAppearanceDefine_h

NS_ASSUME_NONNULL_BEGIN

// 空对象判断
#define bee_ObjectIsEmpty(object) !( \
([object respondsToSelector:@selector(length)] && [(NSData *)object length] > 0) || \
([object respondsToSelector:@selector(count)] && [(NSArray *)object count] > 0) || \
([object respondsToSelector:@selector(floatValue)] && [(id)object floatValue] != 0.0))

/// 获取需要刷新的NSAttributedStringKey数组
static inline NSArray<NSString *> * attributedStringKey(void) {
    static NSArray<NSString *> *t_array = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        t_array = @[
            NSForegroundColorAttributeName, NSShadowAttributeName, NSBackgroundColorAttributeName,
            NSStrikethroughColorAttributeName, NSStrokeColorAttributeName, NSUnderlineColorAttributeName,
            NSAttachmentAttributeName
        ];
    });
    return t_array;
}


NS_ASSUME_NONNULL_END

#endif /* BEEAppearanceDefine_h */
