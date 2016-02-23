//
//  TSTabBarController.m
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//
#import "TSTabBarController.h"

#import "TSPartTimeController.h"
#import "TSMineController.h"
#import "TSMyPushController.h"
#import "TSGroupController.h"

@interface TSTabBarController ()

@end

@implementation TSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabbar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTabbar
{
    TSPartTimeController * patime=[TSPartTimeController new];
    [self addChildViewController:patime WithTitle:@"兼职卫士" andSelectImage:@"TabBar_Client_1_p" andimage:@"TabBar_Client_1_n"];
    
    TSGroupController * group=[TSGroupController new];
    [self addChildViewController:group WithTitle:@"群聊" andSelectImage:@"TabBar_Client_2_p" andimage:@"TabBar_Client_2_n"];
    
    TSMyPushController * mypush=[TSMyPushController new];
    [self addChildViewController:mypush WithTitle:@"我的报名" andSelectImage:@"TabBar_Client_3_p" andimage:@"TabBar_Client_3_n"];
    
    TSMineController * mine=[TSMineController new];
    [self addChildViewController:mine WithTitle:@"个人中心" andSelectImage:@"TabBar_Client_4_p" andimage:@"TabBar_Client_4_n"];
}
-(void)addChildViewController:(UIViewController *)childController WithTitle:(NSString *)title andSelectImage:(NSString  *)selectImageName andimage:(NSString *)imageName
{
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:childController];
    childController.title=title;
    nav.tabBarItem.title=title;
    //设置字体颜色
    NSDictionary * attributeNormal=@{NSForegroundColorAttributeName:[UIColor colorWithRed:169/256.0f green:169/256.0f blue:169/256.0f alpha:1]};
    [nav.tabBarItem setTitleTextAttributes:attributeNormal forState:UIControlStateNormal];
    
    NSDictionary * attributeSelect=@{NSForegroundColorAttributeName:[UIColor colorWithRed:38/256.0f green:203/256.0f blue:92/256.0f alpha:1]};
    [nav.tabBarItem setTitleTextAttributes:attributeSelect forState:UIControlStateSelected];
    
    nav.tabBarItem.image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage=[[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];

}

@end
