//
//  ResultVC.m
//  MobileStation
//
//  Created by DS365 on 16/5/20.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "ResultVC.h"
#import "resultCell.h"
#import "MBNetWorkTool.h"
#import "dataModel.h"
#import "resultModel.h"


@interface ResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * msgList;

@end

@implementation ResultVC
-(NSMutableArray *)msgList
{
    if (_msgList==nil) {
        _msgList=[[NSMutableArray alloc]init];
    }
    return _msgList;
}

-(void)setupUI
{
    [self.tav registerNib:[UINib nibWithNibName:@"resultCell" bundle:nil] forCellReuseIdentifier:@"resultCell"];
    self.tav.delegate=self;
    self.tav.dataSource=self;
    
//    UIButton *  qiehuanBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 60)];
//    [qiehuanBtn setTitle:@"高德地图" forState:UIControlStateNormal];
//    [qiehuanBtn setTitle:@"百度地图" forState:UIControlStateSelected];
//    [qiehuanBtn addTarget:self action:@selector(qiehuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:qiehuanBtn];
 
    self.showBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.showBtn setTitle:@"在地图上显示" forState:UIControlStateNormal];
    [self.showBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.showBtn setBackgroundImage:[UIImage imageNamed:@"bar_topbar"] forState:UIControlStateNormal];
    [self.showBtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)qiehuanBtnClick:(UIButton *)qieHuanBtn
{
    qieHuanBtn.selected=!qieHuanBtn.selected;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getNetWork];

}
-(void)getNetWork
{
    NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"get" forKey:@"type"];
    [dic setObject:@(self.type) forKey:@"mnc"];
    NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
    NSString * usekey=[stand objectForKey:USERKEY];
    [dic setObject:usekey forKey:@"key"];
    for (dataModel * model in self.resultList) {
        [dic setObject:model.cell forKey:@"cell"];
        [dic setObject:model.lac forKey:@"lac"];
        if (![model.nid isEqualToString:@"0"]) {
            [dic setObject:model.nid forKey:@"nid"];
        }
        [[MBNetWorkTool sharedNetworkTools]makeGetRequestwithParameters:dic success:^(NSDictionary *results) {
            
            NSDictionary * succDIC=[results valueForKey:@"result"];
            NSArray * array=[succDIC valueForKey:@"data"];
            for (NSDictionary * dic in array) {
                resultModel * Model=[resultModel objectWithKeyValues:dic];
                [self.msgList addObject:Model];
            }
            [self.tav reloadData];
            NSLog(@"%@",results);
        } fail:^(NSDictionary *results) {
            [MBProgressHUD showWithText:[results valueForKey:@"reason"]];
            NSLog(@"%@",results);
        } error:^(NSError *results) {
            [MBProgressHUD showWithText:[results valueForKey:@"reason"]];
            NSLog(@"%@",results);
        }];
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgList.count;
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    resultModel * model =self.msgList[indexPath.row];
    resultCell * cell=[tableView dequeueReusableCellWithIdentifier:@"resultCell"];
    cell.resultModel=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (IBAction)showBtnClick:(UIButton *)sender {
    if (self.msgList.count==0) {
        [MBProgressHUD showWithText:@"没有基站数据"];
        return;
    }
    NSDictionary *userInfo = @{@"commodityModel" : self.msgList};
    [HMNoteCenter postNotificationName:GETNETWORKLIST object:nil userInfo:userInfo];
}
@end
