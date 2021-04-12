//
//  BDVerticalRuler.h
//  test
//
//  Created by Nantian on 2021/3/8.
//

#import <UIKit/UIKit.h>
#import "BDRulerScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BDVerticalRulerDelegate <NSObject>

//返回scrollview 并返回刻度值，以最小刻度值整数倍计算
- (void)txhRrettyRuler:(BDRulerScrollView *)rulerScrollView withValueOfRuler:(CGFloat)value;

-(void)moveActionFinish;

@end

@interface BDVerticalRuler : UIView

@property (nonatomic, assign) id <BDVerticalRulerDelegate> rulerDeletate;
@property (nonatomic, strong) BDRulerScrollView * rulerScrollView;
@property (nonatomic, assign) long defualtValue;

/*
*  count * average = 刻度最大值
*  @param count        10个小刻度为一个大刻度，大刻度的数量
*  @param average      每个小刻度的值，最小精度 0.1
*  @param currentValue 直尺初始化的刻度值
*/
- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                        currentValue:(CGFloat)currentValue;

// 传入成对的value起止值
-(void)setRulerColorValue:(NSArray *)data;

-(void)setRulerValuePosition:(CGFloat)positionValue;

@end

NS_ASSUME_NONNULL_END
