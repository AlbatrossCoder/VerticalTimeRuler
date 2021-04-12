//
//  ViewController.m
//  testDemo
//
//  Created by Albatross on 2021/3/20.
//

#import "ViewController.h"

@interface ViewController ()<BDVerticalRulerDelegate>
{
    BDVerticalRuler * ruler;
    UILabel * timeLabel;
    UILabel * dateLabel;
    
    BOOL isPlayBack;
    long nowTimeValue;
    long choseTimeValue;
}
@property(nonatomic, strong) HKTimeRulerView * rulerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rulerView = [[HKTimeRulerView alloc]initWithFrame:CGRectMake(150, 80, Screen_width - 20, Screen_height - 80 - 40)];
    [self.view addSubview:self.rulerView];
    ruler = _rulerView.rulerView;
    timeLabel = _rulerView.timeLabel;
    ruler.rulerDeletate = self;
    
    [self setRuller];
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 60, 100, 20)];
    [self.view addSubview:dateLabel];
    dateLabel.font = FONT(14);
    dateLabel.textColor = [UIColor darkTextColor];
    
}

-(void)setRuller{
    long now = [TimeTool getCurrentTimeValue];// 获取当前时间戳
    long dayTimeValue = [TimeTool getTimeValueWithDay:[TimeTool getCurrentDate]];// 获取本日零点时间戳
    [self showRullerWithTimeNow:1440 - (now - dayTimeValue)/60.0];
    nowTimeValue = [self getZreoTimeValue:now];
    NSLog(@"---   %ld",nowTimeValue);
    timeLabel.text = [TimeTool getDetailTimeWithTimeValue:now];
    dateLabel.text = [TimeTool getYYYMMDDWithTimeValue:now];
}

-(void)showRullerWithTimeNow:(long)time{
    // 一天是1440分钟，初始化为一个小时一个大格子
    // currentValue当前时间，以分钟为单位
    [ruler showRulerScrollViewWithCount:1440/6
                                average:[NSNumber numberWithFloat:6]
                           currentValue:time];
}

-(long)getZreoTimeValue:(long)timeValue{
    NSString * dayStr = [TimeTool getYYYMMDDWithTimeValue:timeValue];
    if([dayStr isEqualToString:[TimeTool getYYYMMDDWithTimeValue:[NSDate date].timeIntervalSince1970]]){
        dateLabel.text = @"今日影像";
    }else{
        dateLabel.text = dayStr;
    }
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    NSDate * dayDate = [formatter dateFromString:dayStr];
    
    return [dayDate timeIntervalSince1970];
}

#pragma mark TXHRrettyRulerDelegate

-(void)txhRrettyRuler:(BDVerticalRuler *)rulerScrollView withValueOfRuler:(CGFloat)value{
    NSLog(@"ruler value : %.2lf",(1440 - value));
    choseTimeValue = nowTimeValue + (1440 - value)*60.0;// 这是变更之后的时间戳
    
    timeLabel.text = [TimeTool getDetailTimeWithTimeValue:choseTimeValue];
}

-(void)moveActionFinish{
    NSLog(@"moveActionFinish");
    dateLabel.text = [TimeTool getYYYMMDDWithTimeValue:choseTimeValue];
}

@end
