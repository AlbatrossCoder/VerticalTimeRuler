//
//  HKTimeRulerView.m
//  iOSModuleMonitor
//
//  Created by Nantian on 2021/3/9.
//  Copyright © 2021 APICloud. All rights reserved.
//

#import "HKTimeRulerView.h"
#import "UIView+TAExtension.h"

@implementation HKTimeRulerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews:frame];
    }
    return self;
}

-(void)loadSubviews:(CGRect)frame{
    // 添加时间控件
    self.rulerView = [[BDVerticalRuler alloc]initWithFrame:CGRectMake(0, 0, 80, frame.size.height)];
    [self addSubview:_rulerView];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 1)];// Y值对应的是ruler里面写死的偏移量，有需要的话再改
    [self addSubview:line];
    line.backgroundColor = RGB(22, 148, 156);
    
    UIView * timeView = [[UIView alloc]initWithFrame:CGRectMake(_rulerView.layout_max_x + 10, 0, 100, 32)];
    [self addSubview:timeView];
    timeView.layer.cornerRadius = timeView.layout_height / 2.0;
    timeView.layer.masksToBounds = YES;
    timeView.backgroundColor = RGB(22, 148, 156);
    timeView.layout_center_y = line.layout_center_y;
    
    UIImageView * sj = [[UIImageView alloc]initWithFrame:CGRectMake(timeView.layout_width-timeView.layout_height/2.0-10, 0, 10, 10)];
    [timeView addSubview:sj];
    sj.image = [UIImage imageNamed:@"hk_arrawDown"];
    sj.layout_center_y = timeView.layout_height/2.0;
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(timeView.layout_height/2.0, 0, sj.layout_x - timeView.layout_height/2.0, timeView.layout_height)];
    [timeView addSubview:_timeLabel];
    _timeLabel.text = @"00:00:00";
    _timeLabel.font = FONT(12);
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
}

@end
