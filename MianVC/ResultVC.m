//
//  ResultVC.m
//  MobileStation
//
//  Created by DS365 on 16/5/20.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "ResultVC.h"
#import "resultCell.h"

@interface ResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * taV;
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
-(UITableView *)taV
{
    if (_taV==nil) {
        _taV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        [_taV registerNib:[UINib nibWithNibName:@"resultCell" bundle:nil] forCellReuseIdentifier:@"resultCell"];
        _taV.delegate=self;
        _taV.dataSource=self;
    }
    return _taV;
}
-(void)setupUI
{
    [self.view addSubview:self.taV];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    resultCell * cell=[tableView dequeueReusableCellWithIdentifier:@"resultCell"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
