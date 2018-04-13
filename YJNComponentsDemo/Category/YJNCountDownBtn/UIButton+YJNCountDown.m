//
//  UIButton+YJNCountDown.m
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/4/13.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "UIButton+YJNCountDown.h"

@implementation UIButton (YJNCountDown)
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)unCountTitle countDownTitle:(NSString *)countTitle mainColor:(UIColor *)unCountColor countColor:(UIColor *)countColor {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSTimeInterval seconds = timeLine;//60.f;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds]; // 最后期限
    
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        if (interval > 0) { // 更新倒计时
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = countColor;
                [self setTitle:[NSString stringWithFormat:@"%d%@",interval,countTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
        } else { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = unCountColor;
                [self setTitle:unCountTitle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }
    });
    dispatch_resume(_timer);
}

@end
