//
//  CORegServiceViewController.h
//  CodingForiPad
//
//  Created by sunguanglei on 15/7/24.
//  Copyright (c) 2015年 coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface CORegServiceViewController : UIViewController<BMKLocationServiceDelegate, BMKMapViewDelegate, BMKGeneralDelegate, BMKGeoCodeSearchDelegate>{
    BMKLocationService *_locService;
    BMKGeoCodeSearch* _geocodesearch;
    BMKPointAnnotation *pointAnnotation;
    BOOL setCenter;
    
}@end
