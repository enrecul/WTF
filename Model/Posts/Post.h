//
//  Posts.h
//  WTF
//
//  Created by 黄春涛 on 16/5/24.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "AVObject.h"
#import "WTFUser.h"
#import "Thing.h"

@interface Post : AVObject <AVSubclassing>

@property (nonatomic, strong) Thing *thing;///<从属的小事
@property (nonatomic, copy) NSString *postText;///<文本内容
@property (nonatomic, strong) NSArray *postPohtoIds;///<图片上限9张
@property (retain) AVRelation *praises;///<点赞
@property (retain) AVRelation *comments;///<评论

@property (retain) AVRelation *users;///<参与者
@property (nonatomic, strong) WTFUser *creater;///<创建者

@end
