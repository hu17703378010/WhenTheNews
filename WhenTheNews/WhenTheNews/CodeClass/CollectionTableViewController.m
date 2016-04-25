//
//  CollectionTableViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "ReaddetailController.h"

#import "NewsDetailViewController.h"
#import "CyclePhotoViewController.h"
@interface CollectionTableViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CollectionTableViewController


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        NSString *documents = [self documentsForFilePath];
        self.dataArray = [NSMutableArray arrayWithContentsOfFile:documents];
    }
    return _dataArray;
}


- (NSString *)documentsForFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [filePath.firstObject stringByAppendingPathComponent:@"collectNews.plist"];
    
    return documents;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -64) forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.dataArray.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你还没有收藏资讯，赶快去收藏您喜欢的资讯吧！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }

    [self.editButtonItem setTitle:@"编辑"];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
    self.tableView.tableFooterView = view;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        [self.editButtonItem setTitle:@"完成"];
    } else {
        [self.editButtonItem setTitle:@"编辑"];
    }
    [self.tableView setEditing:editing animated:animated];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self leftButton:nil];
    }
}


- (void)leftButton:(UIBarButtonItem *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [self.dataArray[indexPath.row]valueForKey:@"title"];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ReaddetailController *detail = [[ReaddetailController alloc] init];
//    detail.URLStr = [self.dataArray[indexPath.row] valueForKey:@"url"];
//    detail.titleString = [self.dataArray[indexPath.row] valueForKey:@"title"];
//    detail.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:detail animated:YES];
    
    NSString *title = [self.dataArray[indexPath.row] valueForKey:@"title"];
    NSDictionary *dic = self.dataArray[indexPath.row];
    for (NSString *key in dic.allKeys) {
        if ([key isEqualToString:@"url"]) {
            ReaddetailController *detail = [[ReaddetailController alloc] init];
            detail.URLStr = [self.dataArray[indexPath.row] valueForKey:@"url"];
            detail.titleString = title;
            [self.navigationController pushViewController:detail animated:YES];
        }
        if ([key isEqualToString:@"docid"]) {
            NewsDetailViewController *newsDetail = [[NewsDetailViewController alloc]init];
            newsDetail.titleName = title;
            newsDetail.docid = [self.dataArray[indexPath.row] valueForKey:key];
            [self.navigationController pushViewController:newsDetail animated:YES];
        }
        if ([key isEqualToString:@"skipID"]) {
            CyclePhotoViewController *cyclePhoto = [[CyclePhotoViewController alloc]init];
            cyclePhoto.title_name = title;
            cyclePhoto.photo_skipID = [self.dataArray[indexPath.row] valueForKey:key];
            [self.navigationController pushViewController:cyclePhoto animated:YES];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.dataArray writeToFile:[self documentsForFilePath] atomically:YES];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        
    }
}

@end
