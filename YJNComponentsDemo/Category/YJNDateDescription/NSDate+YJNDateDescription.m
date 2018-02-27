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
    NSString *dateDes = [self compareDateByInterval:[messageDate timeIntervalSince1970]];
    return dateDes;
}

+ (NSString *)compareDateByInterval:(NSTimeInterval)interval {
    NSString *dateDes = @"未知";
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"HH:mm";
    NSDate *preDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *minDes = [formater stringFromDate:preDate];
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval todayZero = [self getMidnightOfTheTimeInterval:now];
    int timeOffset = todayZero - interval;
    int secondsPerDay = 24 *60 *60;

    if (timeOffset <= 0 * secondsPerDay) {//今天
        dateDes = minDes;
    }else if (timeOffset <= 1 *secondsPerDay) {//昨天
        dateDes = [NSString stringWithFormat:@"昨天 %@",minDes];
    }
    else if (timeOffset <= 7 * secondsPerDay) {//一周内
        NSCalendar* calendar = [NSCalendar currentCalendar];
        unsigned unitFlags = NSCalendarUnitWeekday;
        NSDateComponents* preCompo = [calendar components:unitFlags fromDate:preDate];
        switch ([preCompo weekday]) {
            case 1:dateDes = [NSString stringWithFormat:@"星期日 %@",minDes] ;break;
            case 2:dateDes = [NSString stringWithFormat:@"星期一 %@",minDes] ;break;
            case 3:dateDes = [NSString stringWithFormat:@"星期二 %@",minDes] ;break;
            case 4:dateDes = [NSString stringWithFormat:@"星期三 %@",minDes] ;break;
            case 5:dateDes = [NSString stringWithFormat:@"星期四 %@",minDes] ;break;
            case 6:dateDes = [NSString stringWithFormat:@"星期五 %@",minDes] ;break;
            case 7:dateDes = [NSString stringWithFormat:@"星期六 %@",minDes] ;break;
            default:break;
        }
    }else {
        NSCalendar* calendar = [NSCalendar currentCalendar];
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitWeekday;
        NSDateComponents *preCompo = [calendar components:unitFlags fromDate:preDate];
        NSDateComponents *todayCompo = [calendar components:unitFlags fromDate:[NSDate date]];
        if (preCompo.year == todayCompo.year) {//一年内
            formater.dateFormat = @"MM/dd HH:mm";
            dateDes = [NSString stringWithFormat:@"%@",[formater stringFromDate:preDate]];
        }else {//其他
            formater.dateFormat = @"yyyy/MM/dd HH:mm";
            dateDes = [formater stringFromDate:preDate];
        }
    }
    return dateDes;
}

+(NSString *)describeMessageTimeInterval:(NSTimeInterval)timeInterval {
    //如果是毫秒级的时间戳，转换到秒
    if(timeInterval > 140000000000) {
        timeInterval = timeInterval / 1000;
    }
    return [self compareDateByInterval:timeInterval];
}

+(NSTimeInterval)getMidnightOfTheTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *originalDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.dateFormat = @"yyyy-MM-dd";
    NSString *original = [dateFormat stringFromDate:originalDate];
    NSDate *midnightDate = [dateFormat dateFromString:original];
    return [midnightDate timeIntervalSince1970];
}
@end
