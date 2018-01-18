//
//  UIViewController+YJNHUD.h
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/1/16.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YJNHUD)

/**
 在视图上展示HUD

 @param view 目标视图
 @param hint 提示内容
 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

/**
 隐藏HUD
 */
- (void)hideHud;

/**
 显示HUD(默认显示2秒)

 @param hint 提示内容
 */
- (void)showHint:(NSString *)hint;

/**
 在指定位置显示HUD

 @param hint 提示内容
 @param yOffset y轴偏移量(起始点为180)
 */
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;
@end
