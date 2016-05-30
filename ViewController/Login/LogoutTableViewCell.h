//
//  LogoutTableViewCell.h
//  WTF
//
//  Created by 黄春涛 on 16/5/30.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^logOutBlock)();

@interface LogoutTableViewCell : UITableViewCell

@property (nonatomic, strong) logOutBlock logOut;

@end
