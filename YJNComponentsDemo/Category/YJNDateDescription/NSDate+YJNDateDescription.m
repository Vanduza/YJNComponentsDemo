//
//  NSDate+YJNDateDescription.m
//  YJNComponentsDemo
//
//  Created by YangJing on 2018/1/16.
//  Copyright © 2018年 Vanduza. All rights reserved.
//

#import "NSDate+YJNDateDescription.h"

@implementation NSDate (YJNDateDescription)
+(NSString *)describeMessageDate:(NSDate *)messageDate {
    NSString * dateDes  = @"未知";
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH:mm";
    NSString *minDes = [formater stringFromDate:messageDate];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDate *yesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDate *weekAgo = [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay*7];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday;
    NSDateComponents* preCompo       = [calendar components:unitFlags fromDate:messageDate];
    NSDateComponents* yesterDayCompo = [calendar components:unitFlags fromDate:yesterday];
    NSDateComponents* todayCompo     = [calendar components:unitFlags fromDate:today];
    NSDateComponents* weekCompo      = [calendar components:unitFlags fromDate:weekAgo];
    if (preCompo.year == todayCompo.year && preCompo.month == todayCompo.month && preCompo.day == todayCompo.day) {//同日(今天)
        dateDes = minDes;
    }
    else if ( preCompo.year == yesterDayCompo.year && preCompo.month == yesterDayCompo.month && preCompo.day == yesterDayCompo.day) {//同日(昨天)
        dateDes = [NSString stringWithFormat:@"昨天 %@",minDes];
    }
    else if (preCompo.year == weekCompo.year && preCompo.month == weekCompo.month && preCompo.weekOfMonth == weekCompo.weekOfMonth) {//同周(这周内)
        NSInteger weekDay = [preCompo weekday];
        switch (weekDay) {
            case 1:dateDes = [NSString stringWithFormat:@"星期日 %@",minDes] ;break;
            case 2:dateDes = [NSString stringWithFormat:@"星期一 %@",minDes] ;break;
            case 3:dateDes = [NSString stringWithFormat:@"星期二 %@",minDes] ;break;
            case 4:dateDes = [NSString stringWithFormat:@"星期三 %@",minDes] ;break;
            case 5:dateDes = [NSString stringWithFormat:@"星期四 %@",minDes] ;break;
            case 6:dateDes = [NSString stringWithFormat:@"星期五 %@",minDes] ;break;
            case 7:dateDes = [NSString stringWithFormat:@"星期六 %@",minDes] ;break;
            default:break;
        }
    }else if (preCompo.year == todayCompo.year) {//同年(今年内)
        formater.dateFormat = @"MM/dd HH:mm";
        dateDes = [NSString stringWithFormat:@"%@",[formater stringFromDate:messageDate]];
    }else {//不同年
        formater.dateFormat = @"yyyy/MM/dd HH:mm";
        dateDes = [formater stringFromDate:messageDate];
    }
    return dateDes;
}

+(NSString *)describeMessageTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *dateInSecond = nil;
    //如果是毫秒级的时间戳，转换到秒
    if(timeInterval > 140000000000) {
        timeInterval = timeInterval / 1000;
    }
    dateInSecond = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [self describeMessageDate:dateInSecond];
}
@end
