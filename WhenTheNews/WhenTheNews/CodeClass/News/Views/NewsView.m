//
//  NewsView.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "NewsView.h"

#import "ImgAndContextTableViewCell.h"
#import "ImgAndTitleTableViewCell.h"
#import "MoreImgTableViewCell.h"

#import "NewsModel.h"

#import <AFHTTPSessionManager.h>

@interface NewsView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *listArray;

@property(nonatomic,strong)NSString *url;

@end


@implementation NewsView


-(NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contextTable = [[UITableView alloc]initWithFrame:self.bounds];
        [self addSubview:_contextTable];
        _contextTable.delegate = self;
        _contextTable.dataSource = self;
        [self setMoreViewInView];
        self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];    }
    return self;
}

- (void)setMoreViewInView{
    [_contextTable registerNib:[UINib nibWithNibName:@"ImgAndContextTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImgAndContextTableViewCell"];
    [_contextTable registerNib:[UINib nibWithNibName:@"ImgAndTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImgAndTitleTableViewCell"];
    [_contextTable registerNib:[UINib nibWithNibName:@"MoreImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoreImgTableViewCell"];
}

- (void)requesData:(NSString *)typeStr{
    
    NSString *string = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html"];
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *array = dic[typeStr];
        
        for (NSDictionary *temp in array) {
            NewsModel *model = [[NewsModel alloc]init];
            [model setValuesForKeysWithDictionary:temp];
            [_listArray addObject:model];
        }
        
        [_contextTable reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求error");
    }];

    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = [[NewsModel alloc]init];
    if (self.listArray.count > 0) {
        model = self.listArray[indexPath.row];
    }
    if (model.photosetID!=nil) {
        MoreImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreImgTableViewCell"];
        [cell setModelContentToCell:model];
        return cell;
    }else if (model.imgType !=nil){
        ImgAndTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImgAndTitleTableViewCell"];
        [cell setModelContentToCell:model];
        return cell;
    }else{
        ImgAndContextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImgAndContextTableViewCell"];
        [cell setModelContentToCell:model];
        return cell;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = [[NewsModel alloc]init];
    if (self.listArray.count > 0) {
        model = self.listArray[indexPath.row];
    }
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
