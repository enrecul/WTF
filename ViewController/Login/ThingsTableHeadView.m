//
//  ThingsTableHeadView.m
//  WTF
//
//  Created by 黄春涛 on 16/5/30.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "ThingsTableHeadView.h"

#define kHeadView_Height 25
#define kCollectionView_Height 50 //一行高
#define kBottomView_Height 20

@interface ThingsTableHeadView()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pager;

@end

@implementation ThingsTableHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.height = kHeadView_Height + kCollectionView_Height + kBottomView_Height;
        self.backgroundColor = [UIColor colorWithHexString:@"EFEEEA"];
        
        //提示文本
        _tipLabel = ({
            UILabel *view= [UILabel new];
            view.font = kSystemFont;
            view.text = @"已加入的事儿";
            [view sizeToFit];
            
            [self addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(kSmallPadding);
                make.left.equalTo(self).with.offset(kSmallPadding);
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
                make.right.equalTo(self.mas_right).with.offset(-kSmallPadding);
                make.width.mas_equalTo(view.width);
                make.height.mas_equalTo(view.height);
            }];
            
            view;
        });
        
    }
    return self;
}

@end
