//
//  WTFUser.h
//  WTF
//
//  Created by 黄春涛 on 16/5/23.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "AVUser.h"

@interface WTFUser : AVUser<AVSubclassing>

@property (nonatomic, copy) NSString *nickName;///<用户昵称
@property (nonatomic, strong) AVFile *avatarFile;///<用户头像

@property (retain) AVRelation *myThings;///<加入的小事
@property (retain) AVRelation *inThings;///<参与的小事儿
@property (retain) AVRelation *myPosts;///<我的帖子
@property (retain) AVRelation *inPosts;///<参与的帖子

@end
