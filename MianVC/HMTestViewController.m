//
//  HMTestViewController.m
//  01-QQ空间
//
//  Created by apple on 15/2/2.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMTestViewController.h"
#import "EditTableViewCell.h"
#import "CORegServiceViewController.h"

@interface HMTestViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong)UITableView * taV;
@end

@implementation HMTestViewController
-(UITableView *)taV
{
    if (_taV==nil) {
        _taV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        _taV.delegate=self;
        _taV.dataSource=self;
    }
    return _taV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupUI];

}
-(void)setupUI
{
    [self.taV registerNib:[UINib nibWithNibName:@"EditTableViewCell" bundle:nil] forCellReuseIdentifier:@"EditTableViewCell"];
    self.taV.rowHeight=200;
    [self.view addSubview:self.taV];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditTableViewCell"];


    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize viewSize = self.view.bounds.size;
    CGSize serviceSize = CGSizeMake(viewSize.width * 0.5, viewSize.height * 0.7);
    
    CORegServiceViewController *controller = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"CORegServiceViewController"];
    controller.view.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    controller.view.layer.cornerRadius = 4.0;
    controller.view.layer.masksToBounds = YES;
    
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
    
    [UIView animateWithDuration:0.3 animations:^{
        controller.view.center = self.view.center;
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 66)];
    UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 66)];
    [view addSubview:btn];
    [btn setTitle:@"增加一条查询记录" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    return view;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
