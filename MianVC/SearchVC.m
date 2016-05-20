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


@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * taV;
@property (nonatomic,strong)UIButton  * yidongBtn;
@property (nonatomic,strong)UIButton  * liantBtn;
@property (nonatomic,strong)UIButton  * dianXbtn;
@property (nonatomic,assign)int type;
@end

@implementation SearchVC
-(UITableView *)taV
{
    if (_taV==nil) {
        _taV=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, 320, self.view.height-50) style:UITableViewStylePlain];
        _taV.delegate=self;
        _taV.dataSource=self;
        [_taV registerNib:[UINib nibWithNibName:@"EditTableViewCell" bundle:nil] forCellReuseIdentifier:@"EditTableViewCell"];
        [_taV registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"ResultTableViewCell"];
        [_taV setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _taV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
//    self.title=@"查询";
    [self setUpChildVC];
    // Do any additional setup after loading the view.
}
-(void)setUpUI
{
    [self.view addSubview:self.taV];
    [self SetUPBTN];
    UIButton * searchBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.height-88, 320, 88)];
    [searchBtn setBackgroundColor:[UIColor blueColor]];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
}
-(void)setUpChildVC
{
    CORegServiceViewController *controller = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"CORegServiceViewController"];
    controller.view.frame = CGRectMake(320, 0, self.view.width-320, self.view.height);
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
}
-(void)SetUPBTN
{
    CGFloat btnW=320/3;
    CGFloat btnH=90;
    UIButton * yidongBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnW, btnH)];
//    [yidongBtn setTitle:@"移动基站" forState:UIControlStateNormal];
    yidongBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [yidongBtn setImage:[UIImage imageNamed:@"chinaMobile"] forState:UIControlStateNormal];
    [yidongBtn setImage:[UIImage imageNamed:@"chinaMobileSel"] forState:UIControlStateSelected];
    [yidongBtn setBackgroundColor:HMRGBColor(71, 184, 251)];
    yidongBtn.tag=1;
    [yidongBtn addTarget:self action:@selector(BarSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    yidongBtn.selected=YES;
    self.type=0;
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
    
    [self.view addSubview:yidongBtn];
    [self.view addSubview:lianTBtn];
    [self.view addSubview:dianXBtn];
    
    
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
        }
            break;
        case 2:
        {
            self.yidongBtn.selected=NO;
            self.liantBtn.selected=YES ;
            self.dianXbtn.selected=NO;
            self.type=1;
        }
            break;
        case 3:
        {
            self.yidongBtn.selected=NO;
            self.liantBtn.selected=NO ;
            self.dianXbtn.selected=YES;
            self.type=3;
        }
            break;
            
        default:
            break;
    }
}

-(void)searchBtnClick:(UIButton *)searchBtn
{
//    UIButton * showBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,kScreen_Width, kScreen_Height)];
//    [showBtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
////    [showBtn setBackgroundColor:[UIColor orangeColor]];
//    EditTableViewCell * cell=[self.taV dequeueReusableCellWithIdentifier:@"EditTableViewCell"];
//    cell.bounds=CGRectMake(0, 0, 320, 110);
//    [showBtn addSubview:cell];
//    cell.center=showBtn.center;
//    [[UIApplication sharedApplication].keyWindow addSubview:showBtn];
    
    
//    CGSize viewSize = self.view.bounds.size;
//    CGSize serviceSize = CGSizeMake(viewSize.width * 0.5, viewSize.height * 0.7);
    
    ResultVC * controller=[[ResultVC alloc]init];
    [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"ResultVC"];
    controller.view.frame = CGRectMake(0, 0, 320, kScreen_Height);
//    controller.view.layer.cornerRadius = 4.0;
//    controller.view.layer.masksToBounds = YES;
    
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
    
    [UIView animateWithDuration:0.3 animations:^{
        controller.view.center = CGPointMake(160, kScreen_Height*0.5);
    }];
}
-(void)showBtnClick:(UIButton *)showBtn
{
    [showBtn removeFromSuperview];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"EditTableViewCell"];
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


@end
