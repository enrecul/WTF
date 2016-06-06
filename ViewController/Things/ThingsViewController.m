//
//  ThingsViewController.m
//  WTF
//
//  Created by 黄春涛 on 16/5/17.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "ThingsViewController.h"

//Model
#import "WTFUser.h"
#import "Thing.h"

//View
#import "ThingsTableViewCell.h"
#import "ThingsTableHeadView.h"
#import "MoreThingsViewController.h"

#define kDefaultTableViewCell_Height 100;

@interface ThingsViewController ()<
        UITableViewDelegate,
        UITableViewDataSource,
        ThingsTableHeadViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ThingsTableHeadView *tableHeadView;
@end

@implementation ThingsViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	_tableView = ({
		_tableView = [UITableView new];
		[self.view addSubview:_tableView];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		[_tableView registerClass:[ThingsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ThingsTableViewCell class])];

		[_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		         make.edges.equalTo(self.view);
		 }];

		_tableView;
	});

	_tableHeadView = ({
		_tableHeadView = [ThingsTableHeadView new];
		_tableHeadView.delegate = self;
		_tableView.tableHeaderView = _tableHeadView;
		_tableHeadView;
	});
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThingsTableViewCell class]) forIndexPath:indexPath];
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kDefaultTableViewCell_Height;
}


#pragma mark - ThingsTableHeadViewDelegate
- (void)resizeThingsHeadView {
	self.tableView.tableHeaderView = _tableHeadView;
}

-(void)moreThingsBtnClick {
	MoreThingsViewController *moreThingsVC = [MoreThingsViewController new];
	[self.navigationController pushViewController:moreThingsVC animated:YES];
}




@end


















