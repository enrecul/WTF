//
//  ThingsTableHeadView.h
//  WTF
//
//  Created by 黄春涛 on 16/5/30.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThingsTableHeadViewDelegate <NSObject>

- (void)resizeThingsHeadView;

@end

@interface ThingsTableHeadView : UIView

@property (nonatomic, weak) id<ThingsTableHeadViewDelegate> delegate;

@end
