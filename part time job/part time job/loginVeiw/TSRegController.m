//
//  TSRegController.m
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "TSRegController.h"

@interface TSRegController ()
@property (nonatomic,strong)UITextField * phoneNumberField;
@property (nonatomic,strong)UITextField * authCodeField;
@property (nonatomic,strong)UITextField * pswField;
@property (nonatomic,strong)UITextField * inviteCodeField;

@property (nonatomic,strong)UIButton * getAuthCodeBtn;

@property (nonatomic,strong)UIButton * registBtn;

@property (nonatomic,strong)UIButton * loadBtn;

@end

@implementation TSRegController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"注册";
    [self createViews];
    // Do any additional setup after loading the view.
}
-(void)createViews
{
    //初始化并布局手机号输入框
    UITextField * phoneNumberField=[UITextField new];
    self.phoneNumberField=phoneNumberField;
    phoneNumberField.borderStyle=UITextBorderStyleRoundedRect;
    phoneNumberField.placeholder=@"手机号";
    phoneNumberField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.view addSubview:phoneNumberField];
    [phoneNumberField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left);
         make.top.equalTo(self.view.mas_top).offset(64);
         make.right.equalTo(self.view.mas_right);
         make.height.equalTo(40);
     }];
    
    //初始化并布局验证码输入框
    UITextField * authCodeField=[UITextField new];
    self.authCodeField=authCodeField;
    [self.view addSubview:authCodeField];
    authCodeField.borderStyle=UITextBorderStyleRoundedRect;
    authCodeField.placeholder=@"验证码";
    authCodeField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [authCodeField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left);
         make.top.equalTo(phoneNumberField.mas_bottom);
         make.right.equalTo(self.view.mas_right);
         make.height.equalTo(phoneNumberField.mas_height);
     }];
    //初始化并布局密码输入框
    UITextField * pswField=[UITextField new];
    self.pswField=pswField;
    [self.view addSubview:pswField];
    pswField.borderStyle=UITextBorderStyleRoundedRect;
    pswField.placeholder=@"密码";
    pswField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [pswField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left);
         make.top.equalTo(authCodeField.mas_bottom);
         make.right.equalTo(self.view.mas_right);
         make.height.equalTo(phoneNumberField.mas_height);
     }];
    //初始化并布局邀请码输入框
    UITextField * inviteCodeField=[UITextField new];
    self.inviteCodeField=inviteCodeField;
    [self.view addSubview:inviteCodeField];
    inviteCodeField.borderStyle=UITextBorderStyleRoundedRect;
    inviteCodeField.placeholder=@"邀请码";
    inviteCodeField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [inviteCodeField mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.equalTo(self.view.mas_left);
         make.top.equalTo(pswField.mas_bottom);
         make.right.equalTo(self.view.mas_right);
         make.height.equalTo(phoneNumberField.mas_height);
     }];
    
    //初始化并布局获取验证码按钮
    UIButton * getAuthCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.getAuthCodeBtn=getAuthCodeBtn;
    [getAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getAuthCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:getAuthCodeBtn];
    [getAuthCodeBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(phoneNumberField.mas_bottom);
         make.right.equalTo(self.view.mas_right);
         make.width.equalTo(TSScreW*0.4);
         make.height.equalTo(phoneNumberField.mas_height);
     }];
    //初始化并布局注册按钮
    UIButton * registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.registBtn=registBtn;
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(inviteCodeField.mas_bottom).offset(25);
         make.right.equalTo(self.view.mas_right).offset(-20);
         make.left.equalTo(self.view.mas_left).offset(20);
         make.height.equalTo(phoneNumberField.mas_height);
     }];
    //初始化并登录按钮
    UIButton * loadBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loadBtn=loadBtn;
    [self.view addSubview:loadBtn];
    NSString * btnText=@"我已有账号，请登录";
    NSDictionary * attribute=@{NSForegroundColorAttributeName:[UIColor orangeColor],NSUnderlineStyleAttributeName:@(1)};
    NSMutableAttributedString * attributeStr=[[NSMutableAttributedString alloc]initWithString:btnText];
    [attributeStr setAttributes:attribute range:NSMakeRange(7, 2)];
    [loadBtn setAttributedTitle:attributeStr forState:UIControlStateNormal];
    loadBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    
    [loadBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(registBtn.mas_bottom).offset(25);
         make.centerX.equalTo(registBtn.mas_centerX);
         make.width.equalTo(100);
         make.height.equalTo(20);
         
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
