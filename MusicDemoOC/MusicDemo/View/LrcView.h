//
//  ZHLrcView.h
//  QQMusic
//
//  Created by niugaohang on 15/9/11.
//  Copyright (c) 2015年 niu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LrcLabel.h"

@interface LrcView : UIScrollView
//歌词名称
@property (copy, nonatomic) NSString *lrcName;
//当前歌曲播放时间
@property (assign, nonatomic) NSTimeInterval currentTime;
//外面的歌词
@property (weak, nonatomic) LrcLabel *lrcLabel;

@end
