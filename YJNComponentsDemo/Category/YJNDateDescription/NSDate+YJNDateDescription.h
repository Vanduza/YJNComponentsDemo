//
//  NSDate+YJNDateDescription.h
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/1/16.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJNDateDescription)

/**
 描述消息日期

 @param messageDate 消息Date对象
 @return 日期描述
 */
+(NSString *)describeMessageDate:(NSDate *)messageDate;

/**
 描述消息日期

 @param timeInterval 毫秒级或秒级的时间戳
 @return 日期描述
 */
+(NSString *)describeMessageTimeInterval:(NSTimeInterval)timeInterval;

@end
