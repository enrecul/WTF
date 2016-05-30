//
//  Praise.h
//  WTF
//
//  Created by 黄春涛 on 16/5/26.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "AVObject.h"
#import "Post.h"
#import "WTFUser.h"


@interface Praise : AVObject

@property (nonatomic, strong) Post *post;///<被点赞的帖子
@property (nonatomic, strong) WTFUser *creater;///<点赞者

@end
