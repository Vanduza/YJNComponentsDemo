//
//  YJNMultiTabConstant.h
//  FunctionTestOC
//
//  Created by YangJing on 2018/2/26.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#ifndef YJNMultiTabConstant_h
#define YJNMultiTabConstant_h
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YJNMultiTabIndicatorStyle){
    YJNMultiTabIndicatorStyleDefault = 0, //定宽
    YJNMultiTabIndicatorStyleTextWidth = 1, //和文本等宽
    YJNMultiTabIndicatorStyleAverageWidth = 2 //均分屏幕宽度(仅当内容小于屏幕宽度时生效)
};

typedef struct YJNMultiTabViewEdgeInsets {
    CGFloat left,right;
} YJNMultiTabViewEdgeInsets;

UIKIT_STATIC_INLINE YJNMultiTabViewEdgeInsets YJNMultiTabViewOffsetMake(CGFloat left, CGFloat right) {
    YJNMultiTabViewEdgeInsets offset = {left, right};
    return offset;
}

#endif /* YJNMultiTabConstant_h */
