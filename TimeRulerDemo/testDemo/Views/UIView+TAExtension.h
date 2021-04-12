//
//  UIView+TAExtension.h
//  CommunityFinancial
//
//  Created by wuxiyao on 15/10/12.
//  Copyright © 2015年 pactera. All rights reserved.
//

// UIView类别扩展
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (TAExtension)

#pragma mark - autoLayout

@property (assign, nonatomic) CGFloat layout_y;
@property (assign, nonatomic) CGFloat layout_x;
@property (assign, nonatomic) CGPoint layout_min_origin;

@property (assign, nonatomic) CGFloat layout_height;
@property (assign, nonatomic) CGFloat layout_width;
@property (assign, nonatomic) CGSize layout_size;

@property (assign, nonatomic) CGFloat layout_center_x;
@property (assign, nonatomic) CGFloat layout_center_y;
@property (assign, nonatomic) CGPoint layout_center;

@property (assign, nonatomic) CGFloat layout_max_y;
@property (assign, nonatomic) CGFloat layout_max_x;
@property (assign, nonatomic) CGPoint layout_max_origin;

#pragma mark - 获得view的父视图控制器

- (UIViewController *)getViewSuperViewController;

#pragma mark - (CATransition动画实现)

- (void) transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view completion:(void (^) (BOOL finished))completion;

#pragma mark - 根据视图的锚点设置视图的相对俯视图的位置
- (void)LayerputAnchorPoint:(CGPoint)anchorPoint inPoint:(CGPoint)point;

#pragma mark - cornerdious

-(void)setFTCornerdious:(CGFloat)cornerdious;//设置全部圆角

- (UIViewController *)getNearestViewController; //获取view最近的控制器

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;


- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;
@end
