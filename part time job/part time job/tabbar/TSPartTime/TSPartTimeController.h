//
//  TSPartTimeController.h
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSPartTimeController : UIViewController

@property (nonatomic,strong)NSString * channelType;
@property (nonatomic,strong)NSString * city;
@property (nonatomic,strong)NSString * filtrateTime;
@property (nonatomic,strong)NSString * selectedChannel;
@property (nonatomic,strong)NSString * selectedCity;
@property (nonatomic,strong)NSString * selectedTime;

@property (nonatomic,assign)NSInteger currentPage;

@property (nonatomic,strong)NSMutableDictionary * selectDic;

@end
