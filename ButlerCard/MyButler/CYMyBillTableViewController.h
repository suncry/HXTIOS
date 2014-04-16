//
//  CYMyBillTableViewController.h
//  ButlerCard
//
//  Created by niko on 14-3-20.
//  Copyright (c) 2014年 johnny tang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYMyBillTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
//储存需要显示的数据 用于实现表单的折叠
@property(nonatomic,retain)NSMutableArray *dataArray;
//储存消费清单的所有数据
@property(nonatomic,retain)NSMutableArray *allDataArray;
@end
