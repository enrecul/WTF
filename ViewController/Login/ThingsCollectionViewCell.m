//
//  ThingsCollectionViewCell.m
//  WTF
//
//  Created by 黄春涛 on 16/5/31.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "ThingsCollectionViewCell.h"

@interface ThingsCollectionViewCell()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ThingsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _backView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = kButtonCornerRadius;
            view.clipsToBounds = YES;
            
            [self.contentView addSubview:view];
            
            UIEdgeInsets padding = UIEdgeInsetsMake(kSmallPadding, kSmallPadding, kSmallPadding, kSmallPadding);
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).with.insets(padding);
            }];
            
            view;
        });
        
        
        
        
        _label = ({
            UILabel *view = [UILabel new];
            view.font = kSystemFont;
            view.textAlignment = NSTextAlignmentCenter;
            [_backView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_backView);
            }];
            
            view;
        });
        
    }
    
    return self;
}

- (void)setModel{
    _label.text = @"test";
}

@end
