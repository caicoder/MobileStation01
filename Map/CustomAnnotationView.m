//
//  CustomAnnotationView.m
//  监控
//
//  Created by admin on 15/9/18.
//  Copyright (c) 2015年 com.admin. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#import "ZAnnotation.h"



#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

@interface CustomAnnotationView ()


@end

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle= self.aannotation.subtitle;
        self.calloutView.threetitle=self.aannotation.threetitle;
        self.calloutView.fourtitle=self.aannotation.fourtitle;
        self.leftCalloutAccessoryView.frame=CGRectMake(0, 0, 100, 25);
        
        [self.calloutView.portraitView addSubview: self.leftCalloutAccessoryView];
        [self.calloutView.rightimageView addSubview:self.rightCalloutAccessoryView];
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

@end
