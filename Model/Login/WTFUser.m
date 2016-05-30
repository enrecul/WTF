//
//  WTFUser.m
//  WTF
//
//  Created by 黄春涛 on 16/5/23.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "WTFUser.h"

@implementation WTFUser

@dynamic nickName,avatarFile,myThings,inThings,myPosts,inPosts;

+ (NSString *)parseClassName {
    return @"_User";
}

@end
