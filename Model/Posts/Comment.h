//
//  Comment.h
//  WTF
//
//  Created by 黄春涛 on 16/5/26.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "AVObject.h"
#import "Post.h"
#import "WTFUser.h"

@interface Comment : AVObject

@property (nonatomic, strong) Post *post;///<被评论的帖子
@property (nonatomic, strong) WTFUser *fromUser;///<评论人
@property (nonatomic, strong) WTFUser *toUser;///<被评论人

@property (nonatomic, copy) NSString *commentText;///<评论内容

@end
