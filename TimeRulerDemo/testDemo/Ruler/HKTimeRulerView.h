//
//  HKTimeRulerView.h
//  iOSModuleMonitor
//
//  Created by Nantian on 2021/3/9.
//  Copyright © 2021 APICloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDVerticalRuler.h"

NS_ASSUME_NONNULL_BEGIN

@interface HKTimeRulerView : UIView

@property (nonatomic, strong) BDVerticalRuler * rulerView;

@property (nonatomic, strong) UILabel * timeLabel;

@end

NS_ASSUME_NONNULL_END
