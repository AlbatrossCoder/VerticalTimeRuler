//
//  TimeTool.h
//  ModuleDemo
//
//  Created by Alba on 2019/8/24.
//  Copyright © 2019 APICloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeTool : NSObject

// 获取当前时间戳
+(long)getCurrentTimeValue;

// 默认格式 均为 yyyy-MM-dd HH:mm:ss
+(NSDateFormatter *)defaultFormatter;

// 时间戳转日期
+(NSString *)getDateWithTimeValue:(long)time;

+(NSString *)getDetailTimeWithTimeValue:(long)time;

+(NSString *)getHHmmWithTimeValue:(long)time;

+(NSDate *)getNSDateFromDateValue:(long)time;

// 日期转时间戳
+(long)getTimeValueWithDate:(NSString *)dateStr;

// 获取今天的 年-月-日
+(NSString *)getCurrentDate;

// 根据时间戳获取日期
+(NSString *)getYYYMMDDWithTimeValue:(long)time;
+(NSString *)getMMDDWithTimeValue:(long)time;

// 根据时间戳获取某天的0点时间戳
+(long)getDayZeroTime:(long)time;

// 按天获取时间戳
+(long)getTimeValueWithDay:(NSString *)dateStr;

+(NSDate *)getDateFromDateString:(NSString *)dateStr;
@end

NS_ASSUME_NONNULL_END
