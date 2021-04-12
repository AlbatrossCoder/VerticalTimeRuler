//
//  UIView+TAExtension.m
//  CommunityFinancial
//
//  Created by wuxiyao on 15/10/12.
//  Copyright © 2015年 pactera. All rights reserved.
//

#import "UIView+TAExtension.h"

#define kAnimationNormalTime     0.45f

@implementation UIView (TAExtension)

#pragma mark - autoLayout

/**
 像素对齐
 */
- (CGFloat)pixelAlignedCGFloat:(CGFloat)originalValue {
    return roundf(originalValue * [UIScreen mainScreen].scale) / [UIScreen mainScreen].scale;
}

- (CGFloat)layout_y
{
    return self.frame.origin.y;
}

- (void)setLayout_y:(CGFloat)layout_y
{
    CGRect temp = self.frame;
    temp.origin.y = [self pixelAlignedCGFloat:layout_y];
    self.frame = temp;
}

- (CGFloat)layout_x
{
    return self.frame.origin.x;
}

- (void)setLayout_x:(CGFloat)layout_x
{
    CGRect temp = self.frame;
    temp.origin.x = [self pixelAlignedCGFloat:layout_x];
    self.frame = temp;
}

- (void)setLayout_min_origin:(CGPoint)layout_min_origin
{
    CGRect temp = self.frame;
    temp.origin = CGPointMake([self pixelAlignedCGFloat: layout_min_origin.x], [self pixelAlignedCGFloat:layout_min_origin.y]);
    self.frame = temp;
}

- (CGPoint)layout_min_origin
{
    return self.frame.origin;
}

- (CGFloat)layout_height
{
    return self.frame.size.height;
}

- (void)setLayout_height:(CGFloat)layout_height
{
    CGRect temp = self.frame;
    temp.size.height = [self pixelAlignedCGFloat:layout_height];
    self.frame = temp;
}

- (CGFloat)layout_width
{
    return self.frame.size.width;
}

- (void)setLayout_width:(CGFloat)layout_width
{
    CGRect temp = self.frame;
    temp.size.width = [self pixelAlignedCGFloat:layout_width];
    self.frame = temp;
}

- (void)setLayout_size:(CGSize)layout_size
{
    CGRect temp = self.frame;
    temp.size = CGSizeMake([self pixelAlignedCGFloat:layout_size.width], [self pixelAlignedCGFloat:layout_size.height]);
    self.frame = temp;
}

- (CGSize)layout_size
{
    return self.frame.size;
}

- (CGFloat)layout_center_x
{
    return self.center.x;
}

- (void)setLayout_center_x:(CGFloat)layout_center_x
{
//    CGPoint center = self.center;
//    center.x = layout_center_x;
//    self.center = center;
    CGRect temp = self.frame;
    temp.origin.x = [self pixelAlignedCGFloat: layout_center_x - temp.size.width / 2];
    self.frame = temp;
}

- (CGFloat)layout_center_y
{
    return self.center.y;
}

- (void)setLayout_center_y:(CGFloat)layout_center_y
{
//    CGPoint center = self.center;
//    center.y = layout_center_y;
//    self.center = center;
    CGRect temp = self.frame;
    temp.origin.y = [self pixelAlignedCGFloat: layout_center_y - temp.size.height / 2];
    self.frame = temp;
}

- (void) setLayout_center:(CGPoint)layout_center
{
    CGRect temp = self.frame;
    temp.origin.x = [self pixelAlignedCGFloat: layout_center.x - temp.size.width / 2];
    temp.origin.y = [self pixelAlignedCGFloat: layout_center.y - temp.size.height / 2];

    self.frame = temp;
}

- (CGPoint) layout_center
{
    return self.center;
}

- (void)setLayout_max_x:(CGFloat)layout_max_x
{
    CGRect temp = self.frame;
    temp.origin.x = [self pixelAlignedCGFloat:layout_max_x] - self.frame.size.width;
    self.frame = temp;
}

- (CGFloat) layout_max_x
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)layout_max_y
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLayout_max_y:(CGFloat)layout_max_y
{
    CGRect temp = self.frame;
    temp.origin.y = [self pixelAlignedCGFloat:layout_max_y] - self.frame.size.height;
    self.frame = temp;
}

- (CGPoint) layout_max_origin
{
    return CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y + self.frame.size.height);
}

- (void) setLayout_max_origin:(CGPoint)layout_max_origin
{
    CGRect temp = self.frame;
    temp.origin.y = [self pixelAlignedCGFloat:layout_max_origin.y - self.frame.size.height];
    temp.origin.x = [self pixelAlignedCGFloat:layout_max_origin.x - self.frame.size.width];
    self.frame = temp;
}

//- (CGFloat) layout_top
//{
//    return self.frame.origin.y;
//}
//
//- (void) setLayout_top:(CGFloat)layout_top
//{
//    CGRect frame = self.frame;
//    frame.origin.y = layout_top;
//    self.frame = frame;
//}
//
//- (CGFloat) layout_left
//{
//    return self.frame.origin.x;
//}
//
//- (void) setLayout_left:(CGFloat)layout_left
//{
//    CGRect frame = self.frame;
//    frame.origin.x = layout_left;
//    self.frame = frame;
//}
//
//- (CGFloat) layout_bottom
//{
//    return self.frame.size.height + self.frame.origin.y;
//}
//
//- (void) setLayout_bottom:(CGFloat)layout_bottom
//{
//    CGRect frame = self.frame;
//    frame.origin.y = layout_bottom - self.frame.size.height;
//    self.frame = frame;
//}
//
//- (CGFloat) layout_right
//{
//    return self.frame.size.width + self.frame.origin.x;
//}
//
//- (void) setLayout_right:(CGFloat)layout_right
//{
//    CGRect frame = self.frame;
//    frame.origin.x = layout_right - self.frame.size.width;
//    self.frame = frame;
//}

#pragma mark - 获得view的父视图控制器

- (UIViewController *)getViewSuperViewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma mark - (CATransition动画实现)

- (void) transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view completion:(void (^) (BOOL finished))completion
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = kAnimationNormalTime;
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    else
    {
        animation.subtype = kCATransitionFromBottom;
    }
    //设置运动速度
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"animation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationNormalTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (view) {
            [view.layer removeAnimationForKey:@"animation"];
            completion(YES);
        } else {
            completion(NO);
        }
    });
}

- (void)LayerputAnchorPoint:(CGPoint)anchorPoint inPoint:(CGPoint)point{
    CGRect rect = self.layer.frame;
    self.layer.anchorPoint = anchorPoint;
    CGFloat originX = point.x - anchorPoint.x * rect.size.width;
    CGFloat originY = point.y - anchorPoint.y * rect.size.height;
    rect.origin = CGPointMake(originX, originY);
    self.layer.frame = rect;
}

#pragma mark - cornerdious

-(void)setFTCornerdious:(CGFloat)cornerdious{
    
    self.layer.cornerRadius = cornerdious;
    self.layer.masksToBounds = YES;
    
}

- (UIViewController *)getNearestViewController {
    UIResponder *next = [self nextResponder];
    
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }
    
    return nil;
}


- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = lineColor.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:lineView.bounds].CGPath;
    
    border.frame = lineView.bounds;
    //虚线的宽度
    border.lineWidth = lineLength;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@(lineSpacing)];
    
    [lineView.layer addSublayer:border];
    
  
    
}


- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

    
    

@end
