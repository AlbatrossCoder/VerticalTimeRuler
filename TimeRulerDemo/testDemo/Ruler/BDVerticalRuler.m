//
//  BDVerticalRuler.m
//  test
//
//  Created by Nantian on 2021/3/8.
//

#import "BDVerticalRuler.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

@interface BDVerticalRuler ()<UIScrollViewDelegate>
{
    long beginTime;
    UIView * fakeView;
    BOOL isInit;
    BOOL isZooming;
    
    BOOL shoudChange;
    
    long rulerCount;
    NSNumber * rulerAverage;
    long defaultValue;
    float distanceValue;
}

@property(nonatomic, strong)UIScrollView * maskScrollView;
@property(nonatomic, strong)NSMutableArray * valueArr;
@end

@implementation BDVerticalRuler

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.maskScrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.maskScrollView.minimumZoomScale = 1;
        self.maskScrollView.maximumZoomScale = 10;
        self.maskScrollView.bouncesZoom = YES;
        fakeView = [[UIView alloc]initWithFrame:self.maskScrollView.bounds];
        [self.maskScrollView addSubview:fakeView];
        self.maskScrollView.zoomScale = 5;
        
        self.rulerScrollView.rulerHeight = frame.size.height;
        self.rulerScrollView.rulerWidth = frame.size.width;
        
        [self addSubview:self.rulerScrollView];
        [self addSubview:self.maskScrollView];
    }
    return self;
}

-(UIScrollView *)maskScrollView{
    if(_maskScrollView) return _maskScrollView;
    
    _maskScrollView = [UIScrollView new];
    _maskScrollView.showsVerticalScrollIndicator = NO;
    _maskScrollView.showsHorizontalScrollIndicator = NO;
    _maskScrollView.delegate = self;
    _maskScrollView.tag = 234;
    
    return _maskScrollView;
}

- (BDRulerScrollView *)rulerScrollView{
    if(_rulerScrollView) return _rulerScrollView;
    _rulerScrollView = [BDRulerScrollView new];
    _rulerScrollView.delegate = self;
    _rulerScrollView.showsHorizontalScrollIndicator = NO;
    _rulerScrollView.showsVerticalScrollIndicator = NO;
    _rulerScrollView.tag = 567;
    
    return _rulerScrollView;
}

- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                        currentValue:(CGFloat)currentValue{
    NSAssert(_rulerScrollView != nil, @"***** 调用此方法前，请先调用 initWithFrame:(CGRect)frame 方法初始化对象 _rulerScrollView\n");
    NSAssert(currentValue < [average floatValue] * count, @"***** currentValue 不能大于直尺最大值（count * average）\n");
    
    rulerCount = count;
    rulerAverage = average;
    defaultValue = currentValue;
    self.defualtValue = currentValue;
    distanceValue = 10.0;
    
    [self drawRuler];
}

-(void)drawRuler{
    _rulerScrollView.rulerCount = 1440/rulerAverage.intValue;
    _rulerScrollView.rulerAverage = rulerAverage;
    _rulerScrollView.defaultValue = defaultValue;
    _rulerScrollView.distanceValue = distanceValue;
    [_rulerScrollView drawRuler];
    
    isInit = YES;
    self.maskScrollView.contentSize = CGSizeMake(0, self.rulerScrollView.contentSize.height+20);
    self.maskScrollView.contentOffset = self.rulerScrollView.contentOffset;
}

-(void)setRulerColorValue:(NSArray *)data{
    // 将value值转化为ruler的对应offsetY
    _valueArr = [NSMutableArray new];
    
    //获取日期当天零点时间戳
    EZDeviceRecordFile * file = [data lastObject];
    NSString * dayStr = [TimeTool getYYYMMDDWithTimeValue:[file.startTime timeIntervalSince1970]];
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];
    NSDate * dayDate = [formatter dateFromString:dayStr];
    beginTime = [dayDate timeIntervalSince1970];
    NSLog(@"开始日期：%@ - %ld", [TimeTool getDateWithTimeValue:beginTime], beginTime);
    
    for (int i = 0; i<data.count; i++) {
        EZDeviceRecordFile * file = data[i];
        CGFloat startTime = [file.startTime timeIntervalSince1970]-beginTime;
        startTime = startTime > 0 ? startTime : 0;// 早于当天取当天0时
        CGFloat stopTime = [file.stopTime timeIntervalSince1970]-beginTime;
        startTime = 1440 - startTime/60.0;
        stopTime = 1440 - stopTime/60.0;
        
        [_valueArr addObject:@{@"startTime":[NSNumber numberWithFloat:startTime],@"stopTime":[NSNumber numberWithFloat:stopTime]}];
    }
    
    // 调用ruler 绘图
    [_rulerScrollView drawColorRuler:_valueArr];
}

-(void)setRulerValuePosition:(CGFloat)positionValue{
    CGFloat offsety = positionValue - beginTime;
    offsety = offsety < 24*60*60 ? offsety : 24*60*60;
    offsety = offsety > 0 ? offsety : 0;
    offsety = 1440 - offsety/60.0;
    [_rulerScrollView setRulerValuePosition:offsety];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(BDRulerScrollView *)scrollView {
    if(scrollView == self.rulerScrollView){
        CGFloat offSetY = scrollView.contentOffset.y;
        CGFloat ruleValue = (offSetY / distanceValue) * [scrollView.rulerAverage floatValue];
        
        if (ruleValue < 0.f) {
            return;
        } else if (ruleValue > scrollView.rulerCount * [scrollView.rulerAverage floatValue]) {
            return;
        }
        if (self.rulerDeletate) {
            if(!isZooming && !isInit){
                defaultValue = ruleValue;
            }
            [self.rulerDeletate txhRrettyRuler:scrollView withValueOfRuler:ruleValue];
        }
    }else{
        if(isInit){
            isInit = NO;
        }else{
            if(isZooming){
                return;
            }
            self.rulerScrollView.contentOffset = CGPointMake(0, self.maskScrollView.contentOffset.y);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(BDRulerScrollView *)scrollView {
    if(self.rulerScrollView == scrollView){
        if([self.rulerDeletate respondsToSelector:@selector(moveActionFinish)]){
            [self.rulerDeletate moveActionFinish];
        }
    }
}

- (void)scrollViewDidEndDragging:(BDRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate){
        [self scrollViewDidEndDecelerating:scrollView];
    }else{
        [scrollView setContentOffset:scrollView.contentOffset animated:NO];
    }
}

#pragma mark - Zooming

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    if(scrollView == _rulerScrollView) return;
    NSLog(@"scrollViewWillBeginZooming:%ld withView:%ld",scrollView.tag, view.tag);
    isZooming = YES;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if(scrollView == _rulerScrollView) return;
    
    distanceValue = distanceValue * ((scrollView.zoomScale + 15)/20.0);
    NSLog(@"distanceValue:%.2f",distanceValue);
    if(rulerAverage.intValue == 12 && distanceValue < 6){
        distanceValue = 6;
        return;
    }else if (rulerAverage.intValue == 1 && distanceValue > 30){
        distanceValue = 30;
        return;
    }
    
    if (rulerAverage.intValue == 12){
        if(distanceValue > 20){
            distanceValue = 10;
            rulerAverage = [NSNumber numberWithInt:6];
        }
    }else if(rulerAverage.intValue == 6){
        if(distanceValue > 20){
            distanceValue = 10;
            rulerAverage = [NSNumber numberWithInt:3];
        }else if (distanceValue < 5){
            distanceValue = 10;
            rulerAverage = [NSNumber numberWithInt:12];
        }
    }else if (rulerAverage.intValue == 3){
        if(distanceValue > 30){
            distanceValue = 10;
            rulerAverage = [NSNumber numberWithInt:1];
        }else if(distanceValue < 5){
            distanceValue = 10;
            rulerAverage = [NSNumber numberWithInt:6];
        }
    }else if (rulerAverage.intValue == 1){
        if(distanceValue < 10){
            distanceValue = 10;
            rulerAverage = [NSNumber numberWithInt:3];
        }
    }
    
    if(!shoudChange && distanceValue > 0){
        NSLog(@"rulerAverage:%d distanceValue:%.2f",rulerAverage.intValue, distanceValue);
        [self drawRuler];
        [_rulerScrollView drawColorRuler:_valueArr];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->shoudChange = NO;
    });
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    if(scrollView == _rulerScrollView) return;
    NSLog(@"scrollViewDidEndZooming:%ld withView:%ld scale:%f",scrollView.tag, view.tag, scale);
    
    self.maskScrollView.zoomScale = 5;
    self.maskScrollView.contentSize = CGSizeMake(0, self.rulerScrollView.contentSize.height+20);
    self.maskScrollView.contentOffset = self.rulerScrollView.contentOffset;
    isZooming = NO;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return fakeView;
}

@end
