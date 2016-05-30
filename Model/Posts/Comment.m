//
//  Comment.m
//  WTF
//
//  Created by 黄春涛 on 16/5/26.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "Comment.h"

@implementation Comment

@dynamic post,fromUser,toUser,commentText;

+ (NSString *)parseClassName {
    return @"Comment";
}

@end
