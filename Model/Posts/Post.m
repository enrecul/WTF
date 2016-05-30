//
//  Posts.m
//  WTF
//
//  Created by 黄春涛 on 16/5/24.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "Post.h"

@implementation Post

@dynamic thing,postText,postPohtoIds,praises,comments,users,creater;

+ (NSString *)parseClassName {
    return @"Post";
}

@end
