//
//  ViewController.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/7.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "ViewController.h"
#import "MusicModel.h"
#import "MainPageCell.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    数据加载
    [self loadData];
//    注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainPageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MainPageCell"];
}
#pragma mark 数据加载
- (void)loadData
{
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Musics" ofType:@"plist"]];
    for (NSDictionary *dic in arr) {
        MusicModel *model = [[MusicModel alloc]initWithDictionary:dic];
        [self.data addObject:model];
    }
}
#pragma mark 懒加载数组
- (NSMutableArray *)data
{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}
#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainPageCell"];
    cell.model = self.data[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *vc = [DetailViewController new];
    vc.model = self.data[indexPath.row];
    vc.data = self.data;
    vc.currentIndex = indexPath.row;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:vc animated:YES completion:nil];
    });
}
@end
