//
//  TSJZHeaderView.h
//  part time job
//
//  Created by Dylan on 16/2/22.
//  Copyright © 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSScrollViewWithPageView.h"
#import "TSJZAdsModel.h"

@interface TSJZHeaderView : UIView

@property (nonatomic,strong)TSScrollViewWithPageView * adsView;

-(void)configWithArray:(NSArray *)adsArray;

@end
