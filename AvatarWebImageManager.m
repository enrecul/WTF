//
//  AvatarWebImageManager.m
//  WTF
//
//  Created by 黄春涛 on 16/5/27.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "AvatarWebImageManager.h"

@implementation AvatarWebImageManager

+ (YYWebImageManager *)avatarImageManager {
    
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"WTF.avatar"];
        YYImageCache *cache = [[YYImageCache alloc] initWithPath:path];
        manager = [[YYWebImageManager alloc] initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
//        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
//            if (!image) return image;
//            
//            return image;
//        };
    });
    return manager;
}

@end
