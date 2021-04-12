//
//  BDRulerScrollView.h
//  test
//
//  Created by Nantian on 2021/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BDRulerScrollView : UIScrollView
{
    CAShapeLayer *shapeLayer1;
    CAShapeLayer *shapeLayer2;
    CAShapeLayer *shapeLayer3;
}

@property (nonatomic,assign) NSUInteger rulerHeight;

@property (nonatomic,assign) NSUInteger rulerWidth;

@property (nonatomic,assign) NSUInteger rulerCount;

@property (nonatomic,copy) NSNumber * rulerAverage;

@property (nonatomic,assign) CGFloat distanceValue;

@property (nonatomic,assign) CGFloat defaultValue;


-(void)drawRuler;

-(void)drawColorRuler:(NSArray *)data;

-(void)setRulerValuePosition:(CGFloat) positionValue;

@end

NS_ASSUME_NONNULL_END
