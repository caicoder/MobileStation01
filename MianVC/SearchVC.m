//
//  SearchVC.m
//  MobileStation
//
//  Created by DS365 on 16/5/18.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "SearchVC.h"
#import "EditTableViewCell.h"
#import "ResultTableViewCell.h"
#import "CORegServiceViewController.h"
#import "UIImage+Color.h"
#import "ResultVC.h"
#import "InputCell.h"
#import "DataManmager.h"
#import "UIView+Extension.h"
#import "CORootViewController.h"


#import "ShowVC.h"



@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton  * yidongBtn;
@property (nonatomic,strong)UIButton  * liantBtn;
@property (nonatomic,strong)UIButton  * dianXbtn;
@property (nonatomic,assign) int  type;
@property (nonatomic,strong)NSMutableArray * yidongList;
@property (nonatomic,strong)NSMutableArray * liantongList;
@property (nonatomic,strong)NSMutableArray * dianxinList;
@property (nonatomic,strong)UIButton * showBtn;
@property (nonatomic,strong)UIButton * addBtn;
@property (nonatomic,strong)InputCell * inputCell;

@end

@implementation SearchVC
-(UITableView *)taV
{
    if (_taV==nil) {
     
    }
    return _taV;
}
-(void)setupTabV
{
    self.taV.delegate=self;
    self.taV.dataSource=self;
    [self.taV registerNib:[UINib nibWithNibName:@"EditTableViewCell" bundle:nil] forCellReuseIdentifier:@"EditTableViewCell"];
    [self.taV registerNib:[UINib nibWithNibName:@"InputCell" bundle:nil] forCellReuseIdentifier:@"InputCell"];
    [self.taV setBackgroundColor:kGlobalBg];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"查询基站";
    [self setUpUI];
    [self setupTabV];
    [self  addnote];
    [self CreatList];
    self.type=0;
}
-(void)CreatList
{
    _liantongList=[DataManmager sharedDataManmager].liantongList;
    _dianxinList=[DataManmager sharedDataManmager].dianxinList;
    _yidongList=[DataManmager sharedDataManmager].yidongList;
    [self.taV reloadData];
}
-(void)addnote
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showinputView) name:SHOWINPUTVIEW object:nil];
    [HMNoteCenter addObserver:self selector:@selector(reloadTableView:) name:SEARCHVCRELOAD object:nil];
//    [HMNoteCenter addObserver:self selector:@selector(shwBtnRemove) name:SHOWBTNREMOVEFATHERVIEW object:nil];
}
-(void)reloadTableView:(NSNotification *)note
{
    dataModel * model= note.userInfo[@"commodityModel"];
    switch (self.type) {
        case 0:
        {
            [_yidongList insertObject:model atIndex:0];
            [self.taV reloadData];
        }
            break;
        case 1:
        {
            [_liantongList insertObject:model atIndex:0];
            [self.taV reloadData];
        }
            break;
        default :
        {
            [_dianxinList insertObject:model atIndex:0];
            [self.taV reloadData];
        }
            break;
    }
}
-(void)setUpUI
{
  
    [self SetUPBTN];
    [self.searchBtn setBackgroundImage:[UIImage imageNamed:@"bar_topbar"] forState:UIControlStateNormal];
    self.searchBtn.titleLabel.font=[UIFont systemFontOfSize:20];


    
}

-(void)SetUPBTN
{
    CGFloat btnW=self.topView.width/3;
    CGFloat btnH=90;
    UIButton * yidongBtn=[[UIButton alloc]initWithFrame:CGRectMake(2, 0, btnW, btnH)];
//    [yidongBtn setTitle:@"移动基站" forState:UIControlStateNormal];
    yidongBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [yidongBtn setImage:[UIImage imageNamed:@"chinaMobile"] forState:UIControlStateNormal];
    [yidongBtn setImage:[UIImage imageNamed:@"chinaMobileSel"] forState:UIControlStateSelected];
    [yidongBtn setBackgroundColor:HMRGBColor(71, 184, 251)];
    yidongBtn.tag=1;
    [yidongBtn addTarget:self action:@selector(BarSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    yidongBtn.selected=YES;
    self.yidongBtn=yidongBtn;
    
    UIButton * lianTBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yidongBtn.frame), 0, btnW, btnH)];
    [lianTBtn setImage:[UIImage imageNamed:@"chinaUnicom"] forState:UIControlStateNormal];
    [lianTBtn setImage:[UIImage imageNamed:@"chinaUnicomSel"] forState:UIControlStateSelected];
    lianTBtn.tag=2;
     [lianTBtn addTarget:self action:@selector(BarSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.liantBtn=self.liantBtn;
    
    UIButton * dianXBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lianTBtn.frame), 0, btnW, btnH)];
//    [dianXBtn setTitle:@"联通基站" forState:UIControlStateNormal];
    [dianXBtn setImage:[UIImage imageNamed:@"chinaTelecom"] forState:UIControlStateNormal];
    [dianXBtn setImage:[UIImage imageNamed:@"chinaTelecomSel"] forState:UIControlStateSelected];
    dianXBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [dianXBtn setBackgroundColor:HMRGBColor(71, 184, 251)];
    dianXBtn.tag=3;
     [dianXBtn addTarget:self action:@selector(BarSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.dianXbtn=dianXBtn;
    
    [self.topView addSubview:yidongBtn];
    [self.topView addSubview:lianTBtn];
    [self.topView addSubview:dianXBtn];
    
    
}
-(void)BarSelectBtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            self.yidongBtn.selected=YES;
            self.liantBtn.selected=NO ;
            self.dianXbtn.selected=NO;
            self.type=0;
            [self.taV reloadData];
        }
            break;
        case 2:
        {
            self.yidongBtn.selected=NO;
            self.liantBtn.selected=YES ;
            self.dianXbtn.selected=NO;
            self.type=1;
            [self.taV reloadData];
        }
            break;
        case 3:
        {
            self.yidongBtn.selected=NO;
            self.liantBtn.selected=NO ;
            self.dianXbtn.selected=YES;
            self.type=3;
            [self.taV reloadData];
        }
            break;
            
        default:
            break;
    }
}
-(void)showinputView:(UIButton *)btn
{
   

    switch (btn.tag) {
        case 0:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ShowVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowTwoVC"];
            [vc.view setBackgroundColor:[UIColor whiteColor]];
            [[CORootViewController currentRoot] popoverController:vc withSize:CGSizeMake(320, 110)];
            [vc setClickSureBtn:^(dataModel * modeDic) {
                [_yidongList addObject:modeDic];
                [self.taV reloadData];
            }];
   
        }
            break;
        case 1:
        {
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ShowVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowTwoVC"];
            [vc.view setBackgroundColor:[UIColor whiteColor]];
            [[CORootViewController currentRoot] popoverController:vc withSize:CGSizeMake(320, 110)];
            [vc setClickSureBtn:^(dataModel * modeDic) {
                [_liantongList addObject:modeDic];
                [self.taV reloadData];
            }];
        }
            break;

        case 3:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ShowVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowVC"];
            [vc.view setBackgroundColor:[UIColor whiteColor]];
            [[CORootViewController currentRoot] popoverController:vc withSize:CGSizeMake(320, 150)];
            [vc setClickSureBtn:^(dataModel * modeDic) {
                [_dianxinList addObject:modeDic];
                [self.taV reloadData];
            }];
        }
            break;

            
        default:
            break;
    }

    
}
- (IBAction)searchBtnClick:(UIButton *)sender
{

    ResultVC * controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultVC"];
    switch (self.type) {
        case 0:
        {
            controller.resultList=_yidongList;
        }
            break;
        case 1:
        {
            controller.resultList=_liantongList;
        }
            break;
        case 3:
        {
            controller.resultList=_dianxinList;
        }
            break;
            
        default:
            break;
    }
    if (controller.resultList.count<=0) {
        [MBProgressHUD showWithText:@"没有需要查询的基站"];
        return;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.type) {
        case 0:
            return _yidongList.count;
//            return 20;
            break;
            
        case 1:
            return _liantongList.count;
            break;
        case 3:
            return _dianxinList.count;
            break;
            
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.type) {
        case 0:
        {
            EditTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"EditTableViewCell"];
            cell.type=self.type;
            dataModel * model=_yidongList[indexPath.row];
            cell.model=model;
            return  cell;
        }
            break;
            
        case 1:
        {
            
            EditTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"EditTableViewCell"];
            cell.type=self.type;
            dataModel * model=_liantongList[indexPath.row];
            cell.model=model;
            return  cell;
        }
            break;
        case 3:
        {
            EditTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"EditTableViewCell"];
            cell.type=self.type;
            dataModel * model=_dianxinList[indexPath.row];
            cell.model=model;
            return  cell;
        }
            break;
            
        default:
        {
            EditTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"EditTableViewCell"];
            cell.type=self.type;
            return  cell;
        }
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.type) {
        case 0:
            return 110;
            break;
        case 1:
            return 110;
            break;
        case 3:
            return 150;
            break;
        default:
            return 110;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ShowVC *popoverVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowVC"];
//    [popoverVC.view setBackgroundColor:[UIColor whiteColor]];
//    [[CORootViewController currentRoot] popoverController:popoverVC withSize:CGSizeMake(320, 150)];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (self.type) {
        case 0:
        {
            UIButton * footerBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.topView.width, 50)];
            [footerBtn setTitle:@"新增一条记录" forState:UIControlStateNormal];
            [footerBtn setTintColor:[UIColor whiteColor]];
            [footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
            [footerView addSubview:footerBtn];
            footerBtn.tag=self.type;
            [footerBtn setBackgroundImage:[UIImage imageNamed:@"bar_topbar"] forState:UIControlStateNormal];
            [footerBtn addTarget:self action:@selector(showinputView:) forControlEvents:UIControlEventTouchUpInside];
            return footerView;
        }
            break;
        case 1:
        {
            UIButton * footerBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.topView.width, 50)];
            [footerBtn setTitle:@"新增一条记录" forState:UIControlStateNormal];
            [footerBtn setTintColor:[UIColor whiteColor]];
            [footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
            [footerView addSubview:footerBtn];
            footerBtn.tag=self.type;
            [footerBtn setBackgroundImage:[UIImage imageNamed:@"bar_topbar"] forState:UIControlStateNormal];
            [footerBtn addTarget:self action:@selector(showinputView:) forControlEvents:UIControlEventTouchUpInside];
            return footerView;
        }
            break;
        default :
        {
            UIButton * footerBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.topView.width, 50)];
            [footerBtn setTitle:@"新增一条记录" forState:UIControlStateNormal];
            [footerBtn setTintColor:[UIColor whiteColor]];
            [footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            UIView * footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
            [footerView addSubview:footerBtn];
            footerBtn.tag=self.type;
            [footerBtn setBackgroundImage:[UIImage imageNamed:@"bar_topbar"] forState:UIControlStateNormal];
            [footerBtn addTarget:self action:@selector(showinputView:) forControlEvents:UIControlEventTouchUpInside];
            return footerView;
        }
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
