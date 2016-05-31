//
//  ThingsCollectionViewCell.m
//  WTF
//
//  Created by 黄春涛 on 16/5/31.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "ThingsCollectionViewCell.h"

@interface ThingsCollectionViewCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ThingsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _label = ({
            UILabel *view = [UILabel new];
            view.font = kSystemFont;
            [self.contentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(kSmallPadding);
                make.right.equalTo(self.contentView.mas_right).with.offset(-kSmallPadding);
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.height.equalTo(self.contentView.mas_height);
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
