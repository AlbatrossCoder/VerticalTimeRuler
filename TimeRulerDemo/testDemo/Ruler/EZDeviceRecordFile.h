//
//  EZDeviceRecordFile.h
//  testDemo
//
//  Created by Albatross on 2021/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EZDeviceRecordFile : NSObject

/// 设备录像文件的开始时间
@property (nonatomic, strong) NSDate *startTime;
/// 设备录像文件的结束时间
@property (nonatomic, strong) NSDate *stopTime;

@end
NS_ASSUME_NONNULL_END
