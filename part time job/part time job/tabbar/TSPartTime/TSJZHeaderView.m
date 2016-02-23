//
//  TSJZHeaderView.m
//  part time job
//
//  Created by Dylan on 16/2/22.
//  Copyright © 2016年 TS. All rights reserved.
//

#import "TSJZHeaderView.h"

@implementation TSJZHeaderView

-(void)configWithArray:(NSArray *)adsArray
{
    NSInteger pageCount=adsArray.count;
    NSArray * images=@[];
    TSScrollViewWithPageView * adsView=[TSScrollViewWithPageView scrollViewWithFrame:self.bounds andImages:images];
}

@end
