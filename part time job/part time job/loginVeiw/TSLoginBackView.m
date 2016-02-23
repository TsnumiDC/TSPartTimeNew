//
//  TSLoginBackView.m
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "TSLoginBackView.h"
#import "TSLoginView.h"

@interface TSLoginBackView()
@property (nonatomic,strong)UIView * loginView;
@end

@implementation TSLoginBackView

+(instancetype)sharedBackView
{
    static dispatch_once_t onceToken;
    static TSLoginBackView * loginBackView;
    dispatch_once(&onceToken, ^{
        loginBackView =[[TSLoginBackView allocWithZone:NULL]initWithFrame:TSScreFrame];
        loginBackView.backgroundColor=[UIColor grayColor];
        
        TSLoginView * loginView=[TSLoginView sharedLoginView];
        loginBackView.loginView=loginView;
        [loginBackView addSubview:loginView];
        //分别加手势
        [loginBackView addBackGuesture];
        [loginBackView addLoginGuesture];
        
        [loginBackView configBlur];
        [loginBackView configUnderView];
    });
    return loginBackView;
}
//设置高斯模糊
- (void)configBlur {
    // 是否动态更新
    self.dynamic = NO;
    // 是否开启高斯模糊
    self.blurEnabled = YES;
    // 模糊效果
    self.blurRadius = 5.0f;
}

- (void)configUnderView {
    // 以一个 underView 放到高斯模糊背景的下面，控制模糊的颜色效果
    UIView *underView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight)];
    underView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    [self addSubview:underView];
    [underView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
-(void)addBackGuesture//点击背景返回原控制器
{
    UITapGestureRecognizer * tapguesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:tapguesture];
    tapguesture.delegate=self;
}
-(void)addLoginGuesture//点击框内结束编辑
{
    UITapGestureRecognizer * tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit)];
    [self.loginView addGestureRecognizer:tapgesture];
}

-(void)show
{
    UIWindow * window=TSKeyWindow;
    [window addSubview:[TSLoginBackView sharedBackView]];
}
-(void)hide//注意这里的对象方法转类方法
{
    [TSLoginBackView hideView];
}
+(void)hideView
{
    [[self sharedBackView]removeFromSuperview];
}
-(void)removeFromSuperview
{
    //移除子视图
    [self.loginView.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self.loginView removeGestureRecognizer:obj];
    }];
    self.loginView=nil;
    //去除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super removeFromSuperview];
}
-(void)endEdit//这个方法可以收缩键盘
{
    [self endEditing:YES];
}
#pragma mark gesturedelegate
//解决手势冲突，如果点击的地方是loginview 或者点击的父视图是自己，就不允许调用隐藏方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch
{
    if ([touch.view isEqual:self.loginView]||[touch.view.superview isEqual:self])
    {
        return NO;
    }
    else
    {
        return YES;
    }
    
}
@end
