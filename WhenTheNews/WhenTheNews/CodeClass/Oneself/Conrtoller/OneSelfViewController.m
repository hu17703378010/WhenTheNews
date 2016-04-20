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
#import "SDImageCache.h"
#import "ActivityView.h"

@interface OneSelfViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    NSUInteger size;
}

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UILabel *cache;

@property(nonatomic,strong) NSArray *NameArray;
@end


@implementation OneSelfViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    size =[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;//缓存-- MB
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    self.NameArray = @[@"收藏",@"清除缓存",@"护眼模式",@"免责声明",@"版本号"];
   
    [self loadHeaderView];
}

- (void)loadHeaderView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 44 - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = (ScreenHeight - 44 - 64)/10;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, (ScreenHeight - 44 - 64)  / 2)];
    headerImage.image = [UIImage imageNamed:@"fly.png"];
    
    self.tableView.tableHeaderView = headerImage;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"cell";
  
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ident];
    }
        if (indexPath.row == 4) {
            UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, self.tableView.rowHeight / 2 - 13 , 60, 25)];
            version.text = @"V1.01";
            version.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:version];
        } else if (indexPath.row == 1){
            self.cache = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 70, self.tableView.rowHeight / 2 - 13 , 60, 25)];
            
           self.cache.textAlignment = NSTextAlignmentCenter;
            self.cache.text = [NSString stringWithFormat:@"%luMB",(unsigned long)size];
        
            [cell addSubview:self.cache];
            
       }else if (indexPath.row == 2) {
            UISwitch *swith = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 70, self.tableView.rowHeight / 2 - 13 , 60, 25)];
            [swith addTarget:self action:@selector(nightStyle:) forControlEvents:(UIControlEventValueChanged)];
            [cell addSubview:swith];
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.NameArray[indexPath.row];
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


- (void)setupDisclaimerView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否确定清除缓存 ?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action){
//        
//        [[SDImageCache sharedImageCache]clearDisk];
//        //清理完刷新tableView
//        size =[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;//得到新的缓存缓存-- MB
//        [self.tableView reloadData];
        [self clearCache];
        
    }];
    [alertController addAction:cancel];
    [alertController addAction:ensure];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)setupAlertView{
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"声明" message:@"     本app所有内容,包括文字、图⽚、⾳频、视频、软件、程序、以及版式设计等均在⺴上搜集。访问者可将本app提供的内容或服务用于个⼈人学习、研究或欣赏,以及其他⾮非商业性或 ⾮非盈利性⽤用途,但同时应遵守著作权法及其他相关法律的规定,不得侵犯本app及相关权利⼈人的合法权利。除此以外,将本app任何内容或服务⽤用于其他⽤用途时,须征得本app及相关权利人的书面许可,并支付报酬。本app内容原作者如不愿意在本app刊登内容,请及时通知本app,予以删除。" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
}





// 清除缓存
- (void)clearCache
{
    ActivityView *view = [[ActivityView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 60, ScreenHeight / 2 - 120, 120, 120)];
    [view layoutView];
    [self.view addSubview:view];
   [self clear];
    
}

- (void)clear{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@", cachPath);
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files :%lu",[files count]);
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];}
                   );
    

//        [[SDImageCache sharedImageCache]clearDisk];
//        size = [[SDImageCache sharedImageCache]getSize]/1024.0/1024.0;
//        [self.tableView reloadData];
//    
//        
//    });
//    [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];



}

- (void)clearCacheSuccess{
    
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    ActivityView *aView = [[ActivityView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 60, ScreenHeight / 2 - 120, 120, 120)];
    [aView endClearView];
    [self.view addSubview:aView];
    
});


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


@end
