//
//  TSJZCell.m
//  part time job
//
//  Created by Dylan on 16/2/22.
//  Copyright © 2016年 TS. All rights reserved.
//

#import "TSJZCell.h"
@interface TSJZCell()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;

@end
@implementation TSJZCell
+(TSJZCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * identifity=NSStringFromClass([self class]);
    UINib * nib=[UINib nibWithNibName:identifity bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifity];
    return [tableView dequeueReusableCellWithIdentifier:identifity];
}
-(void)configModel:(TSJZModel *)model
{
    self.titleLabel.text=model.title;
    self.subLabel.text=model.district;
    self.salaryLabel.text=model.showprice;
}
@end
