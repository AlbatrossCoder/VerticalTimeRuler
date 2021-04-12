//
//  BDRulerScrollView.m
//  test
//
//  Created by Nantian on 2021/3/8.
//

#import "BDRulerScrollView.h"

@interface BDRulerScrollView ()

@end

@implementation BDRulerScrollView

- (void)drawRuler {
    if(shapeLayer1 != nil){
        [shapeLayer1 removeFromSuperlayer];
    }
    if(shapeLayer2 != nil){
        [shapeLayer2 removeFromSuperlayer];
    }
    [self.layer layoutSublayers];
    
    for (UIView * view in self.subviews) {
        if([view isKindOfClass:[UILabel class]]){
            [view removeFromSuperview];
        }
    }
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:.8].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:.8].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 4.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    long zeroTime = [TimeTool getDayZeroTime:[TimeTool getCurrentTimeValue]];
    
    if(_rulerAverage.intValue == 1){
        for (int i = 0; i <= self.rulerCount; i++) {
            if (i % 5 == 0) {
                UILabel *rule = [[UILabel alloc] init];
                rule.textColor = [UIColor lightGrayColor];
                rule.font = [UIFont systemFontOfSize:12];
                
                NSInteger timeValue = i * self.rulerAverage.floatValue * 60;
                
                rule.text = [TimeTool getHHmmWithTimeValue:zeroTime - timeValue];
                CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
                
                CGPathMoveToPoint(pathRef1, NULL,  self.rulerWidth - 16 -4,20 + _distanceValue * i);
                CGPathAddLineToPoint(pathRef1, NULL, self.rulerWidth - 4,20 + _distanceValue * i);
                
                [rule sizeToFit];
                rule.frame = CGRectMake(self.rulerWidth - 16 - 4 - rule.frame.size.width - 6 , 20 + _distanceValue * i - textSize.height / 2.0, rule.frame.size.width, rule.frame.size.height);
                
                [self addSubview:rule];
            }else{
                CGPathMoveToPoint(pathRef1, NULL, self.rulerWidth - 8 - 4,20 + _distanceValue * i );
                CGPathAddLineToPoint(pathRef1, NULL, self.rulerWidth  - 4,20 + _distanceValue * i);
            }
        }
    }else{
        for (int i = 0; i <= self.rulerCount; i++) {
            if (i % 10 == 0) {
                UILabel *rule = [[UILabel alloc] init];
                rule.textColor = [UIColor lightGrayColor];
                rule.font = [UIFont systemFontOfSize:12];
                
                NSInteger timeValue = i * self.rulerAverage.floatValue * 60;
                
                rule.text = [TimeTool getHHmmWithTimeValue:zeroTime - timeValue];
                CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
                
                CGPathMoveToPoint(pathRef1, NULL,  self.rulerWidth - 16 -4,20 + _distanceValue * i);
                CGPathAddLineToPoint(pathRef1, NULL, self.rulerWidth - 4,20 + _distanceValue * i);
                
                [rule sizeToFit];
                rule.frame = CGRectMake(self.rulerWidth - 16 - 4 - rule.frame.size.width - 6 , 20 + _distanceValue * i - textSize.height / 2.0, rule.frame.size.width, rule.frame.size.height);
                
                [self addSubview:rule];
            }
            else
            {
                CGPathMoveToPoint(pathRef1, NULL, self.rulerWidth - 8 - 4,20 + _distanceValue * i );
                CGPathAddLineToPoint(pathRef1, NULL, self.rulerWidth  - 4,20 + _distanceValue * i);
            }
        }
    }
    
    shapeLayer1.path = pathRef1;// 刻度
    
    CGPathMoveToPoint(pathRef2, NULL, self.rulerWidth - 2, 20);
    CGPathAddLineToPoint(pathRef2, NULL, self.rulerWidth - 2, 20 + self.rulerCount * _distanceValue);
    shapeLayer2.path = pathRef2;// 灰色
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    self.contentSize = CGSizeMake( self.rulerWidth, self.rulerCount * _distanceValue + self.rulerHeight - 20);
    
    [self setRulerValuePosition:self.defaultValue];
}

-(void)setRulerValuePosition:(CGFloat)positionValue{
    float offsety = _distanceValue * (positionValue / [self.rulerAverage floatValue]);
    [self setContentOffset:CGPointMake(0, offsety) animated:NO];
}

-(void)drawColorRuler:(NSArray *)data{
    CGMutablePathRef pathRef3 = CGPathCreateMutable();
    
    if(shapeLayer3){
        [shapeLayer3 removeFromSuperlayer];
        [self.layer layoutSublayers];
    }
    shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.strokeColor = [UIColor colorWithRed:22/255.0 green:148/255.0 blue:156/255.0 alpha:1].CGColor;
    shapeLayer3.fillColor = [UIColor clearColor].CGColor;
    shapeLayer3.lineWidth = 4.f;
    shapeLayer3.lineCap = kCALineCapButt;
    
    for (int i = 0; i<data.count; i++) {
        // 取值
        NSDictionary * dic = data[i];
        NSNumber * startPoint = dic[@"startTime"];
        NSNumber * stopPoint = dic[@"stopTime"];
        
        CGFloat startY = _distanceValue * (startPoint.floatValue / [self.rulerAverage floatValue]) + 20;
        CGFloat endY = _distanceValue * (stopPoint.floatValue / [self.rulerAverage floatValue]) + 20;
        
        //绘线
        CGPathMoveToPoint(pathRef3, NULL, self.rulerWidth - 2, startY );
        CGPathAddLineToPoint(pathRef3, NULL, self.rulerWidth  - 2, endY);
    }
    
    shapeLayer3.path = pathRef3;// 着色
    [self.layer addSublayer:shapeLayer3];
    [self.layer layoutIfNeeded];
}

@end
