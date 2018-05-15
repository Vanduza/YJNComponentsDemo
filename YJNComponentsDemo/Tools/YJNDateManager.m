//
//  YJNDateManager.m
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/5/15.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "YJNDateManager.h"

@implementation YJNDateManager
+(NSArray *)yjn_getRecentMonths:(NSInteger)recentMonthCount {
    NSDate * nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeInterval nowTimestamp = [nowDate timeIntervalSince1970];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nowDate];
    NSUInteger numberOfDaysInMonth = range.length;
    
    NSMutableArray *months = [[NSMutableArray alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMM";
    for (int i = 0; i < recentMonthCount; i++) {
            //格式化时间
        NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:(nowTimestamp - 86400 * numberOfDaysInMonth * i)];
        NSString *monthString = [formatter stringFromDate:targetDate];
        [months addObject:monthString];
    }
    return months;
}

+ (NSString *)yjn_getLastDayWithMonth:(NSString *)monthStr {
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMM"];
    NSDate *newDate=[format dateFromString:monthStr];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return lastString;
}
@end
