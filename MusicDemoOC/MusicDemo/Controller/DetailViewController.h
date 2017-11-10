//
//  DetailViewController.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/8.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
@interface DetailViewController : UIViewController
@property (strong, nonatomic) MusicModel *model;
@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSInteger currentIndex;
@end
