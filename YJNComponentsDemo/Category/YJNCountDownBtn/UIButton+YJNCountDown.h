//
//  UIButton+YJNCountDown.h
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/4/13.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YJNCountDown)
/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param countTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)unCountTitle countDownTitle:(NSString *)countTitle mainColor:(UIColor *)unCountColor countColor:(UIColor *)countColor;
@end
