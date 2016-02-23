//
//  TSLoginView.h
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSLoginView : UIView

@property (nonatomic,strong)UITextField * phoneNumberField;
@property (nonatomic,strong)UITextField * pswField;
@property (nonatomic,strong)UIButton * loadBtn;
@property (nonatomic,strong)UIButton * registBtn;
@property (nonatomic,strong)UIButton * findPswBtn;

+(instancetype)sharedLoginView;

@end
