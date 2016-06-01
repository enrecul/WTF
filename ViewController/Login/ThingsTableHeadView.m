//
//  ThingsTableHeadView.m
//  WTF
//
//  Created by 黄春涛 on 16/5/30.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "ThingsTableHeadView.h"
#import "ThingsCollectionViewCell.h"
#import "WTFUser.h"

#define kHeadView_Height 47
#define kCollectionView_Height 50 //一行高
#define kBottomView_Height 10

@interface ThingsTableHeadView()<
UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pager;

@property (nonatomic, strong) NSMutableArray *myThings;

@end

@implementation ThingsTableHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = kDefaultBackgroundColor;
        self.frame = CGRectMake(0, 0, ScreenWidth, kBottomView_Height + kCollectionView_Height + kBottomView_Height);
        _myThings = [NSMutableArray array];
        
        //提示文本
        _tipLabel = ({
            UILabel *view= [UILabel new];
            view.font = kSystemFont;
            view.text = @"已加入的事儿";
            [view sizeToFit];
            
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(kLargePadding);
                make.left.equalTo(self).with.offset(kLargePadding);
                make.width.mas_equalTo(view.width);
                make.height.mas_equalTo(view.height);
            }];
            
            view;
        });
        
        //更多事儿Btn
        _moreButton = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"更多事儿" forState:UIControlStateNormal];
            [view setTitleColor:kDefaultTintColor forState:UIControlStateNormal];
            [view.titleLabel setFont:kSystemFont];
            [view sizeToFit];
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_tipLabel);
                make.right.equalTo(self.mas_right).with.offset(-kLargePadding);
                make.width.mas_equalTo(view.width);
                make.height.mas_equalTo(view.height);
            }];
            
            view;
        });
        
        _collectionView = ({
            
            CGFloat itemWidth = ScreenWidth/2;
            CGFloat itemHeight = kCollectionView_Height;
            
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.itemSize = CGSizeMake(itemWidth, itemHeight);
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            [_collectionView registerClass:[ThingsCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ThingsCollectionViewCell class])];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            _collectionView.pagingEnabled = YES;
            _collectionView.showsHorizontalScrollIndicator = NO;
            _collectionView.backgroundColor = kDefaultBackgroundColor;
            
            [self addSubview:_collectionView];
            
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.top.equalTo(self.mas_top).with.offset(kHeadView_Height);
                make.height.mas_equalTo(0);
            }];
            
            _collectionView;
        });
        
        _pager = ({
            UIPageControl *view = [[UIPageControl alloc] init];
            view.hidesForSinglePage = YES;
            view.userInteractionEnabled = NO;
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
            view.currentPage = 0;
            view.numberOfPages = 0;
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.top.equalTo(_collectionView.mas_bottom);
                make.height.mas_equalTo(kBottomView_Height);
            }];
            
            view;
        });
        
        //获取数据源（我加入的事儿）
        AVRelation *relation = [[WTFUser currentUser] relationForKey:@"myThings"];
        AVQuery *query = [relation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            _myThings = [objects mutableCopy];
            _myThings = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"].mutableCopy;
            
            [_collectionView reloadData];
            
            //调整SubView的高度
            [self resizeSubViews];
            
        }];
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _myThings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ThingsCollectionViewCell *cell = (ThingsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ThingsCollectionViewCell class]) forIndexPath:indexPath];
    [cell setModel];
    
    return cell;
}



#pragma mark - Private Method
- (void)resizeSubViews{
    
    [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(kHeadView_Height);
        make.height.mas_equalTo(MIN(kCollectionView_Height * 3, (_myThings.count/2 + _myThings.count%2)*kCollectionView_Height));
    }];
    
    [_pager mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(_collectionView.mas_bottom);
        make.height.mas_equalTo(_myThings.count == 0 ? 0 : kBottomView_Height);
    }];
    
    self.height = kHeadView_Height
    + MIN(kCollectionView_Height * 3, (_myThings.count/2 + _myThings.count%2)*kCollectionView_Height)
    + (_myThings.count == 0 ? 0 : kBottomView_Height);
    
    if ([self.delegate respondsToSelector:@selector(resizeThingsHeadView)]) {
        [self.delegate resizeThingsHeadView];
    }

}

@end






