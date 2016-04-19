//
//  OneSelfViewController.m
//  WhenTheNews
//
//  Created by lanou3g on 16/4/15.
//  Copyright © 2016年 HCC. All rights reserved.
//

#import "OneSelfViewController.h"
#import "AppDelegate.h"
#import "CollectionTableViewController.h"

@interface OneSelfViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end


@implementation OneSelfViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 44 - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = (ScreenHeight - 44 - 64)/10;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
   
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenHeight - 44 - 64)  / 2)];
    
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:headerView.bounds];
    headerImage.image = [UIImage imageNamed:@""];
    [headerView addSubview:headerImage];
    headerView.backgroundColor = [UIColor redColor];
    
    self.tableView.tableHeaderView = headerView;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"cell";
    NSArray *NameArray = @[@"收藏",@"清除缓存",@"护眼模式",@"免责声明",@"版本号"];
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ident];
        if (indexPath.row == 4) {
            UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 60, self.tableView.rowHeight / 2 - 13 , 35, 25)];
            version.text = @"V1.0";
            version.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:version];
        } else if (indexPath.row == 1){
            
            
            
        }else if (indexPath.row == 2) {
            UISwitch *swith = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, self.tableView.rowHeight / 2 - 13 , 60, 25)];
            [swith addTarget:self action:@selector(nightStyle:) forControlEvents:(UIControlEventValueChanged)];
            [cell addSubview:swith];
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = NameArray[indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        CollectionTableViewController *collection = [[CollectionTableViewController alloc]initWithStyle:(UITableViewStylePlain)];
        collection.navigationItem.title = @"收藏列表";
        [collection setHidesBottomBarWhenPushed:YES];
        
        [self.navigationController pushViewController:collection animated:YES];
        
    }else if (indexPath.row == 1){
        [self setupDisclaimerView];
        
    }else if (indexPath.row == 3){
        [self setupAlertView];
    }
    
}

- (void)setupAlertView{
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"声明" message:@"     本app所有内容,包括文字、图⽚、⾳频、视频、软件、程序、以及版式设计等均在⺴上搜集。访问者可将本app提供的内容或服务用于个⼈人学习、研究或欣赏,以及其他⾮非商业性或 ⾮非盈利性⽤用途,但同时应遵守著作权法及其他相关法律的规定,不得侵犯本app及相关权利⼈人的合法权利。除此以外,将本app任何内容或服务⽤用于其他⽤用途时,须征得本app及相关权利人的书面许可,并支付报酬。本app内容原作者如不愿意在本app刊登内容,请及时通知本app,予以删除。" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
}

- (void)setupDisclaimerView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确定清除缓存 ?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action){
    }];
    [alertController addAction:cancel];
    [alertController addAction:ensure];
    [self presentViewController:alertController animated:YES completion:nil];

    
}
// 护眼模式
- (void)nightStyle:(UISwitch *)sender
{
    NSLog(@"%@",sender.on?@"YES":@"NO");
    
    
    if (sender.on) {
        [AppDelegate  shareAppDelegate].redView.alpha = 1;
    }else{
        [AppDelegate shareAppDelegate].redView.alpha = 0.0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
