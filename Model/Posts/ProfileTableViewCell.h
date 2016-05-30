//
//  ProfileTableViewCell.h
//  WTF
//
//  Created by 黄春涛 on 16/5/26.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTFUser.h"

typedef void (^editProfileBlock)();

@interface ProfileTableViewCell : UITableViewCell

@property (nonatomic, strong) editProfileBlock editProfileBlock;

- (void)setWTFUser:(WTFUser *)user;

@end
