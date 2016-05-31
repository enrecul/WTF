//
//  UI-Prefix.h
//  WTF
//
//  Created by 黄春涛 on 16/5/26.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#ifndef UI_Prefix_h
#define UI_Prefix_h

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define kLargePadding 15
#define kMiddlePadding 10
#define kSmallPadding 5

#define kMeVC_AvatarView_WH 50


//字体大小
#define kLabelFont [UIFont systemFontOfSize:[UIFont labelFontSize]]
#define kButtonFont [UIFont systemFontOfSize:[UIFont buttonFontSize]]
#define kSmallSystemFont [UIFont systemFontOfSize:[UIFont smallSystemFontSize]]
#define kSystemFont [UIFont systemFontOfSize:[UIFont systemFontSize]]
#define kRegularFont [UIFont systemFontOfSize:([UIFont systemFontSize] + 4)]

#define kLabelFontSize [UIFont labelFontSize]
#define kButtonFontSize [UIFont buttonFontSize]
#define kSmallSystemFontSize [UIFont smallSystemFontSize]
#define kSystemFontSize [UIFont systemFontSize]
#define kRegularFontSize ([UIFont systemFontSize] + 4)


//颜色
#define kDefaultTintColor [UIColor colorWithHexString:@"005AFF"]

//圆角设置
#define kButtonCornerRadius 5;


#endif /* UI_Prefix_h */
