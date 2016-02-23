//
//  TSMineController.m
//  part time job
//
//  Created by 晨 on 16/2/19.
//  Copyright (c) 2016年 TS. All rights reserved.
//

#import "TSMineController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface TSMineController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation TSMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏，用了苹果四有方法，没有被检测出来
    self.fd_prefersNavigationBarHidden=YES;
    [self configTableView];
    // Do any additional setup after loading the view.
}
-(void)configTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectNull style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    //设为no会被挡住
    self.automaticallyAdjustsScrollViewInsets=NO;
    //这样设置会有毛玻璃效果
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, TSTabbarH, 0);//
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

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowNumber=0;
    switch (section) {
        case 0:
            rowNumber=2;
            break;
        case 1:
            rowNumber=3;
            break;
        case 2:
            rowNumber=1;
            break;
            
        default:
            break;
    }
    return rowNumber;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifity=@"mineCell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifity];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifity];
    }
    cell.textLabel.text=@"扫码测试";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去掉动画
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //[self.navigationController presentationController:[TSScanQRController new]];
    TSScanQRController * scanVC=[TSScanQRController new];
    UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:scanVC];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}
//去掉分组间隙
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
    }
    return 16;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
//-(void)tab
//-(BOOL)prefersStatusBarHidden
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
