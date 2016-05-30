//
//  ProfileTableViewCell.m
//  WTF
//
//  Created by 黄春涛 on 16/5/26.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "ProfileTableViewCell.h"
#import "AvatarWebImageManager.h"

@interface ProfileTableViewCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;
@property (nonatomic, strong) UIButton *editButton;

@end

@implementation ProfileTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:({
            _avatarImageView = [UIImageView new];
            _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
            _avatarImageView;
        })];
        
        [self.contentView addSubview:({
            _nameLabel = [UILabel new];
            _nameLabel.font = kRegularFont;
            _nameLabel;
        })];
        
        [self.contentView addSubview:({
            _createTimeLabel = [UILabel new];
            _createTimeLabel;
        })];
        
        [self.contentView addSubview:({
            _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_editButton setTitle:@"编辑资料" forState:UIControlStateNormal];
            [_editButton setTitleColor:kDefaultTintColor forState:UIControlStateNormal];
            _editButton.titleLabel.font = kSystemFont;
            _editButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            _editButton.layer.borderWidth = 1;
            _editButton.layer.borderColor = kDefaultTintColor.CGColor;
            _editButton.layer.cornerRadius = kButtonCornerRadius;
            _editButton.clipsToBounds = YES;
            [_editButton addTarget:self action:@selector(editProfile) forControlEvents:UIControlEventTouchUpInside];
            [_editButton sizeToFit];
            _editButton;
        })];
        
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kLargePadding);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kMeVC_AvatarView_WH, kMeVC_AvatarView_WH));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_avatarImageView.mas_top);
            make.left.equalTo(_avatarImageView.mas_right).with.offset(kLargePadding);
            make.height.mas_equalTo(kRegularFontSize);
            make.right.equalTo(self.contentView.mas_right).with.offset(-100);
        }];
        
        [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarImageView.mas_right).with.offset(kLargePadding);
            make.bottom.equalTo(_avatarImageView.mas_bottom);
            make.height.mas_equalTo([UIFont systemFontSize]);
            make.right.equalTo(self.contentView.mas_right).with.offset(-100);
        }];
        
        [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(_editButton.size.width + 20);
            make.height.mas_equalTo(_editButton.size.height);
        }];
        
    }
    return self;
}

//设置content
- (void)setWTFUser:(WTFUser *)user{
    if (!user) {
        return;
    }
    
    _nameLabel.text = user.nickName;
    _createTimeLabel.text = [user.createdAt stringWithFormat:@"yyyy-MM-dd HH:mm:ss 加入"];
    
    NSLog(@"avatarUrl:%@",user.avatarFile.url);
    
    [_avatarImageView setImageWithURL:[NSURL URLWithString:user.avatarFile.url]
                          placeholder:nil
                              options:kNilOptions
                              manager:[AvatarWebImageManager avatarImageManager]
                             progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                 
                             }];
    
}

- (void)editProfile{
    self.editProfileBlock();
}

@end
