//
//  TimeTool.m
//  ModuleDemo
//
//  Created by Alba on 2019/8/24.
//  Copyright © 2019 APICloud. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

+(long)getCurrentTimeValue{
    NSDate *datenow = [NSDate date];
    return [datenow timeIntervalSince1970];
}

+(NSDateFormatter *)defaultFormatter{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    
    return dateformatter;
}

+(NSString *)getDateWithTimeValue:(long)time{
    if(!time) return @"";////空值
    
    NSTimeInterval timeS= time;//如果有时差问题 可以加上28800秒
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timeS];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [TimeTool defaultFormatter];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

+(NSString *)getDetailTimeWithTimeValue:(long)time{
    NSDate *detaildate = [self getNSDateFromDateValue:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    
    NSString *currentDateStr = [dateformatter stringFromDate: detaildate];
    
    return currentDateStr;
}

+(NSString *)getHHmmWithTimeValue:(long)time{
    NSDate *detaildate = [self getNSDateFromDateValue:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    
    NSString *currentDateStr = [dateformatter stringFromDate: detaildate];
    
    return currentDateStr;
}

+ (NSDate *)getNSDateFromDateValue:(long)time{
    if(!time) return [NSDate date];////空值返回当前时间
    
    NSTimeInterval timeS= time;//如果有时差问题 可以加上28800秒
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timeS];
    
    return detaildate;
}

+(long)getTimeValueWithDate:(NSString *)dateStr{
    NSDate * time = [[TimeTool defaultFormatter] dateFromString:dateStr];
    long stamp = [time timeIntervalSince1970];
    
    return stamp;
}

// 当前日期
+(NSString *)getCurrentDate{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterShortStyle];
    [dateformatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return [NSString stringWithFormat:@"%@ 00:00:00",locationString];
}

+(NSString *)getMMDDWithTimeValue:(long)time{
    NSDate * date = [self getNSDateFromDateValue:time];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterShortStyle];
    [dateformatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    [dateformatter setDateFormat:@"MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@",locationString];
}

+ (NSString *)getYYYMMDDWithTimeValue:(long)time{
    NSDate * date = [self getNSDateFromDateValue:time];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateStyle:NSDateFormatterShortStyle];
    [dateformatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@",locationString];
}

+(long)getDayZeroTime:(long)time{
    NSString * dayStr = [TimeTool getYYYMMDDWithTimeValue:time];
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    NSDate * dayDate = [formatter dateFromString:dayStr];
    long zeroTimeValue = [dayDate timeIntervalSince1970];
    
    return zeroTimeValue;
}

// 日期转时间戳
+(long)getTimeValueWithDay:(NSString *)dateStr{
    
    NSDate *date = [[TimeTool defaultFormatter] dateFromString:dateStr];
    
    return [date timeIntervalSince1970];
}

+(NSDate *)getDateFromDateString:(NSString *)dateStr{
    
    return [[TimeTool defaultFormatter] dateFromString:dateStr];
}

@end
