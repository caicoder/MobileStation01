//
//  CustomCalloutView.m
//  监控
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 com.admin. All rights reserved.
//

#import "CustomCalloutView.h"


#define kArrorHeight        10

#define kPortraitMargin     5
#define kPortraitWidth     100   //leftimage宽
#define kPortraitHeight     25

#define kTitleWidth         180
#define kTitleHeight        20



@interface CustomCalloutView ()


@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic,strong)UILabel *threetitleLabel;
@property(nonatomic,strong)UILabel *fourtitleLabel;

@end
@implementation CustomCalloutView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame=CGRectMake(0, 0, 200, 125);
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}


- (void)initSubViews
{
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 89)];
    backView.backgroundColor=[UIColor colorWithRed:225/255.0 green:53/255.0 blue:43/255.0 alpha:0.8];
    
    [self addSubview:backView];
    
    
    self.userInteractionEnabled=YES;
    // 添加图片，即商户图
    self.portraitView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kPortraitMargin * 2 + kTitleHeight+kTitleHeight+kTitleHeight+kTitleHeight, kPortraitWidth, kPortraitHeight)];
    self.portraitView.layer.cornerRadius=8;
    self.portraitView.clipsToBounds=YES;
    self.portraitView.userInteractionEnabled=YES;
    self.portraitView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.portraitView];
    
    self.rightimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0+kPortraitWidth, kPortraitMargin * 2 + kTitleHeight+kTitleHeight+kTitleHeight+kTitleHeight, kPortraitWidth, kPortraitHeight)];
    self.rightimageView.clipsToBounds=YES;
    self.rightimageView.layer.cornerRadius=8;
    self.rightimageView.userInteractionEnabled=YES;
    self.rightimageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.rightimageView];
    
    
    
    
    // 添加标题，即商户名
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 , kPortraitMargin, kTitleWidth, kTitleHeight)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"titletitletitletitle";
    [backView addSubview:self.titleLabel];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 , kPortraitMargin  + kTitleHeight, kTitleWidth, kTitleHeight)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:14];
    self.subtitleLabel.textColor = [UIColor whiteColor];
    self.subtitleLabel.text = @"subtitleLabelsubtitleLabelsubtitleLabel";
    [backView addSubview:self.subtitleLabel];
    
    self.threetitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kPortraitMargin * 2, kPortraitMargin + kTitleHeight+kTitleHeight, kTitleWidth, kTitleHeight)];
    self.threetitleLabel.font=[UIFont systemFontOfSize:14];
    
    self.threetitleLabel.textColor = [UIColor whiteColor];
    self.threetitleLabel.text = @"subtitleLabelsubtitleLabelsubtitleLabel";
    [backView addSubview:self.threetitleLabel];
    
    
    self.fourtitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(kPortraitMargin * 2, kPortraitMargin + kTitleHeight+kTitleHeight+kTitleHeight, kTitleWidth, kTitleHeight)];
   
    self.fourtitleLabel.font=[UIFont systemFontOfSize:14];
    self.fourtitleLabel.textColor = [UIColor whiteColor];
    self.fourtitleLabel.text = @"subtitleLabelsubtitleLabelsubtitleLabel";
    [backView addSubview:self.fourtitleLabel];
    
}
- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    //背景颜色
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 0.0;   //北背景图片的圆角
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

- (void)setLeftimage:(UIImage *)leftimage
{
    self.portraitView.image = leftimage;
}
-(void)setRightimage:(UIImage *)rightimage
{
    self.rightimageView.image=rightimage;
}
-(void)setThreetitle:(NSString *)threetitle
{
    self.threetitleLabel.text=threetitle;
}
-(void)setFourtitle:(NSString *)fourtitle
{
    self.fourtitleLabel.text=fourtitle;
}
@end
