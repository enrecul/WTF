//
//  MoreThingsViewController.m
//  WTF
//
//  Created by 黄春涛 on 16/6/3.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "MoreThingsViewController.h"
#import "MoreThingsTableViewCell.h"
#import "Thing.h"
#import "WTFUser.h"
#import "CreateThingViewController.h"

@interface MoreThingsViewController ()<
        UITableViewDelegate,
        UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *thingsArray;

@end

@implementation MoreThingsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = kDefaultBackgroundColor;
    
    [self.navigationItem setRightBarButtonItem:({
        UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"创建事儿" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClicked)];
        
        barBtnItem;
    })];

	_thingsArray = [NSMutableArray array];

	_tableView = ({
		UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.tableFooterView = [UIView new];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = kDefaultBackgroundColor;
		tableView.delegate = self;
		tableView.dataSource = self;
		[tableView registerClass:[MoreThingsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MoreThingsTableViewCell class])];
        [self.view addSubview:tableView];
        
		tableView;
	});
    
	//获取数据源
	AVQuery *query = [Thing query];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _thingsArray = [objects mutableCopy];
        [_tableView reloadData];
	 }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _thingsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	MoreThingsTableViewCell *cell = (MoreThingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MoreThingsTableViewCell class]) forIndexPath:indexPath];
    [cell setModel:[_thingsArray objectAtIndex:indexPath.row]];
    
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - Target & Action
- (void)rightBarButtonClicked{
    CreateThingViewController *createThingVC = [CreateThingViewController new];
    [self presentViewController:createThingVC animated:YES completion:nil];
}

@end
