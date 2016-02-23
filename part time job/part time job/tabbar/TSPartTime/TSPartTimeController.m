//
//  TSPartTimeController.m
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "TSPartTimeController.h"
#import "TSRegController.h"
#import "TSJZModel.h"
#import "TSJZAdsModel.h"
#import "TSJZCell.h"
#import <YYModel.h>
#import <MJRefresh.h>
//导航分类，控制器分类，隐藏导航条
#import "UINavigationController+FDFullscreenPopGesture.h"
//从后台进入程序

//扫码，中间有可识别区域
@interface TSPartTimeController ()<UITableViewDataSource,UITableViewDelegate>
//存放返回的数据
@property (nonatomic,strong)NSMutableArray * adsArray;

@property (nonatomic,strong)NSMutableArray * models;

@property (nonatomic,strong)UITableView * tableView;
@end

@implementation TSPartTimeController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        //无论如何都会执行，如同coder,initwithStyle
        self.models=[NSMutableArray array];
        self.adsArray=[NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self downLoadData];
    [self configCodition];
    [self configTableVeiw];
    [self configADS];
    // Do any additional setup after loading the view.
}
//设置接口字典
-(void)configCodition
{
    self.channelType = @"0";
    self.city = @"";
    self.filtrateTime = @"";
    self.selectedChannel = @"类型";
    self.selectedCity = @"区域";
    self.selectedTime = @"时间";
    self.selectDic = [[NSMutableDictionary alloc] initWithDictionary:@{
                                                                       @"channelType": @"0",
                                                                       @"city": @"",
                                                                       @"filtrateTime": @"",
                                                                       @"selectedChannel": @"类型",
                                                                       @"selectedCity": @"区域",
                                                                       @"selectedTime": @"时间"
                                                                       }];
}
//下载数据
-(void)downLoadData
{
    NSString *currentPageStr = [NSString stringWithFormat:@"%ld", self.currentPage];
    NSDictionary *parameters = @{
                                 @"token": TOKEN,
                                 @"refer": @"sy",
                                 @"tag": @"xs1",
                                 @"page": currentPageStr,
                                 @"channel_type": [self.selectDic objectForKey:@"channelType"],
                                 @"city": [self.selectDic objectForKey:@"city"],
                                 @"filtrate_time": [self.selectDic objectForKey:@"filtrateTime"],
                                 @"tag_time": @""
                                 };
    [TSNetManager getWithParam:parameters andPath:@"app_api.php" andComplete:^(BOOL success, id result) {
        if (success)
        {
            NSError * error;
            NSDictionary * root=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
            if (error)
            {
                NSLog(@"%@",error);
            }
            NSArray * tempArray=root[@"json_data"];
            [self.models removeAllObjects];
            [self.models addObjectsFromArray:[NSArray yy_modelArrayWithClass:[TSJZModel class] json:tempArray]];
            [self.tableView reloadData];
            if ([self.tableView.mj_header isRefreshing])
            {
                 [self.tableView.mj_header endRefreshing];
            }
           
        }
        else
        {
            NSLog(@"首页请求失败%@",result);
        }
    }];
}

//FrameAccessor
-(void)configTableVeiw
{
    self.tableView=[[UITableView alloc]initWithFrame:TSScreFrame];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //设为no会被挡住
    self.automaticallyAdjustsScrollViewInsets=NO;
    //这样设置会有毛玻璃效果
    self.tableView.contentInset=UIEdgeInsetsMake(TSNavH, 0, TSTabbarH, 0);//
    self.tableView.scrollIndicatorInsets=UIEdgeInsetsMake(TSNavH, 0, TSTabbarH, 0);//导航条不会被挡住
    //tableVeiw的footerview 改写，重新初始化就不会显示了
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //去掉左边空白
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    //修改分割线颜色
    self.tableView.separatorColor=[UIColor grayColor];
    //顶部加载进度
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self downLoadData];
    }] ;
    
    
}
-(void)configADS
{
    //http://wap2.yojianzhi.com/app_api.php?token= 565e9507862572d85920de12a783e09f&refer= sy&tag=lbt
    NSDictionary * prarm=@{
                           @"token":TOKEN,
                           @"refer":@"sy",
                           @"tag":@"lbt"
                           };
    [TSNetManager getWithParam:prarm andPath:@"app_api.php" andComplete:^(BOOL success, id result) {
        if (success)
        {
            NSError * error;
            NSArray * tempArray=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"首页轮播json失败：%@",error);
            }
            [self.adsArray removeAllObjects];
            [self.adsArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[TSJZAdsModel class] json:tempArray]];
            NSLog(@"%ld",self.adsArray.count);
        }
        else
            NSLog(@"首页轮播失败：%@",result);
    }];
}
-(void)btnTouch
{
    [self.view addSubview: [TSLoginBackView sharedBackView]];
}
#pragma mark delegate datadource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSJZCell * cell=[TSJZCell cellWithTableView:tableView];
    [cell configModel:self.models[indexPath.row]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
