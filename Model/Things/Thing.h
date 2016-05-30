//
//  Things.h
//  WTF
//
//  Created by 黄春涛 on 16/5/24.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "AVObject.h"
#import "WTFUser.h"

@interface Thing : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *thingsTitle;
@property (nonatomic, copy) NSString *thingsDetail;

@property (nonatomic, strong) WTFUser *creater ;

@property (retain) AVRelation *users;


@end
