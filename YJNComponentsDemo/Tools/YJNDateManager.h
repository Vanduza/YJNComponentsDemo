//
//  YJNDateManager.h
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/5/15.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJNDateManager : NSObject

/**
 获取最近几个月的月份

 @param recentMonthCount 几个月 例如:recentMonthCount = 12,获取最近12个月的所有月份
 @return 目标月份数组 格式:@[@"yyyyMM"]
 */
+(NSArray *)yjn_getRecentMonths:(NSInteger)recentMonthCount;

/**
 获取指定月份的最后一天

 @param monthStr 指定月份 格式:@"yyyyMM"
 @return 最后一天 格式:@"yyyyMMdd"
 */
+ (NSString *)yjn_getLastDayWithMonth:(NSString *)monthStr;

/**
 获取今天零点的时间戳

 @return 零点的时间戳
 */
+(NSInteger)yjn_getTodayZero;
@end
