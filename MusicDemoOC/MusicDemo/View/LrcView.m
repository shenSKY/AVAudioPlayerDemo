//
//  LrcView.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/9.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "LrcView.h"
#import "LrcTool.h"
#import "Lrcline.h"
#import "LrcCell.h"
#import "LrcLabel.h"

@interface LrcView() <UITableViewDelegate,UITableViewDataSource>
//显示歌词的TableView
@property (strong, nonatomic) UITableView *tableView;
//歌词数据
@property (strong, nonatomic) NSArray *lrcs;
//当前正在播放的歌词下标
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation LrcView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupTableView];
    }
    return self;
}


- (void)setupTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LrcCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LrcCell"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.tableView setFrame:(CGRect){self.frame.size.width,0,self.frame.size.width,self.frame.size.height}];
//    设置多余的滑动区域
    self.tableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height * 0.5, 0, self.bounds.size.height * 0.5, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - 重写lrcName的方法
- (void)setLrcName:(NSString *)lrcName
{
    _lrcName = lrcName;
//    解析歌词
    self.lrcs = [LrcTool getLrcsWithLrcName:lrcName];
//    刷新
    [self.tableView reloadData];
}
#pragma mark - 重写CurrentTime的方法
- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;
//    和数组中歌词的时间对比,找出应该显示的歌词
    NSInteger count = self.lrcs.count;
    for (int i = 0; i < count; i++) {
//        取出当前歌词
        LrcLine *lrcLine = self.lrcs[i];
//        取出下一句歌词
        NSInteger nextIndex = i + 1;
        if (nextIndex > count - 1) {
            return;
        }
        LrcLine *nextLrcLine = self.lrcs[nextIndex];
//        让当前播放时间和当前句歌词的时间和下一句歌词的时间对比,如果当前时间大于等于当前句歌词的时间,并且小于下一句歌词的时间,显示该句歌词
        if (currentTime >= lrcLine.time && currentTime < nextLrcLine.time && self.currentIndex != i) {
//            获取前一句播放歌词的NSIndexPath
            NSMutableArray *indexs = [NSMutableArray array];
            if (self.currentIndex < count - 1) {
                NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
                [indexs addObject:previousIndexPath];
            }
//            记录当前播放句的下标值
            self.currentIndex = i;
//            获取当前句的NSIndexPath
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [indexs addObject:indexPath];
//            刷新歌词
            [self.tableView reloadRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationNone];
//            让tableView的当前播放的句,滚动中间位置
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//            改变外面歌词Label显示的文字
            self.lrcLabel.text = lrcLine.lrc;
        }
//        如果正在更新某一句歌词
        if (self.currentIndex == i) {
//            取出i位置的cell
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            LrcCell *cell = (LrcCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//            更新cell中的lrcLabel的进度
            cell.lrcLabel.progress = (currentTime - lrcLine.time) / (nextLrcLine.time - lrcLine.time);
//            改变外面歌词Label显示的进度
            self.lrcLabel.progress = (currentTime - lrcLine.time) / (nextLrcLine.time - lrcLine.time);
        }
    }
}
#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LrcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LrcCell"];
    if (indexPath.row == self.currentIndex) {
        cell.lrcLabel.font = [UIFont systemFontOfSize:18];
    }else {
        cell.lrcLabel.font = [UIFont systemFontOfSize:16];
        cell.lrcLabel.progress = 0;
    }
    LrcLine *lrcLine = self.lrcs[indexPath.row];
    cell.lrcLabel.text = lrcLine.lrc;
    return cell;
}

@end

