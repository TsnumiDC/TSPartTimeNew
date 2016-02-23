//
//  TSLoginBackView.h
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"

@interface TSLoginBackView : FXBlurView<UIGestureRecognizerDelegate>

+(instancetype)sharedBackView;

+(void)hide;

@end
