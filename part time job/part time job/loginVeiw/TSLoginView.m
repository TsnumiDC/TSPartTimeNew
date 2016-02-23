//
//  TSLoginView.m
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "TSLoginView.h"
#import "ReactiveCocoa.h"
#import "TSTabBarController.h"
#import "TSRegController.h"

@implementation TSLoginView

+(instancetype)sharedLoginView
{
    static TSLoginView * loginView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginView =[TSLoginView new];
        loginView.backgroundColor=[UIColor whiteColor];
        loginView.frame=CGRectMake(16, TSScreH*0.22, TSScreW-2*16, TSScreH*0.45);
        [loginView createViewsWithLoginView:loginView];
        
    });
    return loginView;
}

-(void)createViewsWithLoginView:(TSLoginView *)loginView//注意要加前缀
{
    //设置手机号输入框
    UITextField * phoneNumberField=[UITextField new];
    loginView.phoneNumberField=phoneNumberField;
    phoneNumberField.borderStyle=UITextBorderStyleRoundedRect;
    phoneNumberField.placeholder=@"手机号";
    phoneNumberField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [loginView addSubview:phoneNumberField];
    [phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(10);
         make.top.equalTo(10);
         make.right.equalTo(-10);
         make.height.equalTo(50);
     }];
    //设置密码输入框
    UITextField * pswField=[UITextField new];
    pswField.borderStyle=UITextBorderStyleRoundedRect;
    pswField.placeholder=@"这里输入密码";
    pswField.clearButtonMode=UITextFieldViewModeWhileEditing;
    pswField.secureTextEntry=YES;
    loginView.pswField=pswField;
    [loginView addSubview:pswField];
    [pswField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(10);
         make.top.equalTo(phoneNumberField.mas_bottom).offset(10);
         make.width.equalTo(phoneNumberField.mas_width);
         make.height.equalTo(50);
     }];
    UIButton * seePswBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    seePswBtn.selected=YES;
    [seePswBtn setImage:[UIImage imageNamed:@"Password_hide"] forState:UIControlStateNormal];
    [seePswBtn setImage:[UIImage imageNamed:@"Password_show"] forState:UIControlStateSelected];
    pswField.rightView=seePswBtn;
    pswField.rightViewMode=UITextFieldViewModeAlways;
    [seePswBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.size.equalTo(CGSizeMake(50, 50));
     }];
    [seePswBtn addTarget:self action:@selector(seePswBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置登录按钮
    UIButton * loadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loadBtn=loadBtn;
    [loadBtn setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
    [loadBtn setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [loadBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(loadBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    [loginView addSubview:loadBtn];
    [loadBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(10);
         make.top.equalTo(pswField.mas_bottom).offset(40);
         make.width.equalTo(phoneNumberField.mas_width);
         make.height.equalTo(60);
     }];
    
    //设置免费注册按钮效果及位置
    UIButton * registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.registBtn=registBtn;
    NSString * regisTitle=@"免费注册";
    NSDictionary * attribute=@{NSForegroundColorAttributeName:[UIColor orangeColor],NSUnderlineStyleAttributeName:@(1)};
    NSMutableAttributedString * attributeStr=[[NSMutableAttributedString alloc]initWithString:regisTitle];
    [attributeStr setAttributes:attribute range:NSMakeRange(0, 4)];
    [registBtn setAttributedTitle:attributeStr forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    registBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [loginView addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(10);
         make.top.equalTo(loadBtn.mas_bottom).offset(30);
         make.height.equalTo(20);
         make.width.equalTo(80);
     }];
    
    //设置忘记密码位置及属性
    UIButton * forgetPswBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.findPswBtn=forgetPswBtn;
    [loginView addSubview:forgetPswBtn];
    [forgetPswBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetPswBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [forgetPswBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetPswBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.equalTo(-10);
         make.top.equalTo(loadBtn.mas_bottom).offset(30);
         make.height.equalTo(20);
         make.width.equalTo(80);
     }];
    
    //逻辑
    RAC(self.loadBtn,enabled)=[RACSignal combineLatest:@[self.phoneNumberField.rac_textSignal,self.pswField.rac_textSignal] reduce:^id(NSString * phoneNumber,NSString * psw){
        NSLog(@"%@,%@",phoneNumber,psw);
        return @(phoneNumber.length==11&&psw.length>=6);
    }];
}
-(void)seePswBtnTouch:(UIButton *)btn
{
    //18513017173 qqqqqq
    btn.selected=!btn.selected;
    self.pswField.secureTextEntry=!self.pswField.secureTextEntry;
}
-(void)loadBtnTouch
{
    NSDictionary * param = @{
                                @"phone":self.phoneNumberField.text,
                             @"password":self.pswField.text
                             };
    [TSNetManager postWithParam:param andPath:@"/app_api.php?token=565e9507862572d85920de12a783e09f&refer=zx&tag=yhdl" andComplete:^(BOOL success, id result)
    {
        if (success)
        {
            NSLog(@"登录成功:%@",result);
        }
        else
        {
            NSLog(@"登录失败:%@",result);
        }
    }];
}
-(void)registBtnTouch
{
    [TSLoginBackView hide];
    TSTabBarController *tabbar=(TSTabBarController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    UINavigationController * nav=(UINavigationController *)tabbar.selectedViewController;
    TSRegController * regis=[TSRegController new];
    [nav pushViewController:regis animated:YES];
}
@end
