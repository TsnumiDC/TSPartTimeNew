//
//  TSJZCell.h
//  part time job
//
//  Created by Dylan on 16/2/22.
//  Copyright © 2016年 TS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSJZModel.h"

@interface TSJZCell : UITableViewCell

-(void)configModel:(TSJZModel *)model;

+(TSJZCell *)cellWithTableView:(UITableView *)tableView;

@end
