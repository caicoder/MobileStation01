//
//  CORootViewController.m
//  MobileStation
//
//  Created by DS365 on 16/5/28.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "CORootViewController.h"
#import "ShowVC.h"
#import "UIView+Extension.h"

static CORootViewController *rootController = nil;
static dispatch_once_t onceToken;

@interface CORootViewController ()

@property (nonatomic, strong) NSMutableDictionary *controller;

@property (nonatomic, strong) UIViewController *popController;
@property (nonatomic, strong) UIButton *maskView;
@property (nonatomic, strong) UIView *popShadowView;
@property (nonatomic, assign )CGRect rect;

@end

@implementation CORootViewController


+ (instancetype)currentRoot
{
    return rootController;
}
+ (void)clear
{
    onceToken = 0;
}

- (void)viewDidLoad {
  
    [super viewDidLoad];
      rootController=self;
    [self.DoduckBg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar_topbar"]]];
    [self setupUI];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    dispatch_once(&onceToken, ^{
        [self performSegueWithIdentifier:@"message" sender:self.searchBtn];
    });
//    UIStoryboard *login = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ShowVC * vc= [login instantiateViewControllerWithIdentifier:@"ShowVC"];
//    [self popoverController:vc withSize:CGSizeMake(320, 150)];
    
}

-(void)setupUI
{
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_coding_big_dark"]];
    logo.frame=CGRectMake(0, 0, 110, 30);
    self.navigationItem.titleView = logo;
    [self setupKeyboardNotification];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




- (void)chageController:(UIViewController *)destination
{
    if (_selectedController) {
        //        [_selectedController viewWillDisappear:NO];
        [_selectedController.view removeFromSuperview];
        //        [_selectedController viewDidDisappear:NO];
        _selectedController = nil;
    }
    
    //    [destination viewWillAppear:NO];
    destination.view.frame = _container.bounds;
    [_container addSubview:destination.view];
        [destination viewDidAppear:NO];
    _selectedController = destination;
}

#pragma mark - action
- (void)unSelectBtn:(UIButton *)selectBtn
{
    for (id view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = view;
            if (btn.selected && btn!=selectBtn) {
                btn.selected = NO;
//                if (btn != _userBtn) {
//                    for (NSLayoutConstraint *con in btn.superview.constraints) {
//                        if (con.firstItem == btn && con.firstAttribute == NSLayoutAttributeLeft) {
//                            con.constant = 6;
//                        }
//                    }
//                }
            }
        }
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if (_controller[identifier]) {
        UIButton *btn = nil;
        if ([sender isKindOfClass:[UIButton class]]) {
            btn = sender;
        }
        [self unSelectBtn:btn];
        if (btn && !btn.selected) {
            btn.selected = YES;
//            if (btn != _userBtn) {
                for (NSLayoutConstraint *con in btn.superview.constraints) {
                    if (con.firstItem == btn && con.firstAttribute == NSLayoutAttributeLeft) {
                        con.constant = 10;
                    }
//                }
            }
        }
        if (_controller[identifier] != self.selectedController) {
            [self chageController:_controller[identifier]];
        }
        //        [self chageBgForIdentifier:identifier];
//        [self changeBackground:_controller[identifier]];
        
        return NO;
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // FixMe: 处理不同情况的segue
    //    [self chageBgForIdentifier:segue.identifier];
//    [self changeBackground:segue.destinationViewController];
    
//    if ([segue.identifier isEqualToString:@"selfInfo"]) {
//        [segue.destinationViewController setValue:[COSession session].user forKey:@"user"];
//        return;
//    }
    
    if ([segue.identifier isEqualToString:@"message"]) {
        self.msgController = segue.destinationViewController;
    }
    
    if ([segue isKindOfClass:[COContainerSegue class]]) {
        UIButton *btn = nil;
        if ([sender isKindOfClass:[UIButton class]]) {
            btn = sender;
        }
//        [self unSelectBtn:btn];
//        if (btn && !btn.selected) {
//            btn.selected = YES;
//            if (btn != _userBtn) {
//                for (NSLayoutConstraint *con in btn.superview.constraints) {
//                    if (con.firstItem == btn && con.firstAttribute == NSLayoutAttributeLeft) {
//                        con.constant = 10;
//                    }
//                }
//            }
//        }
        [_controller setObject:segue.destinationViewController forKey:segue.identifier];
        [self chageController:segue.destinationViewController];
    }
}



#pragma mark - pop
- (void)popoverController:(UIViewController *)controller withSize:(CGSize)size
{
    BOOL reset =FALSE;
    if (self.popController) {
        reset = TRUE;
        _popShadowView.backgroundColor = [UIColor clearColor];
        [_popController.view removeFromSuperview];
        [_popController removeFromParentViewController];
        self.popController = nil;
    }
    
    if (self.maskView == nil) {
        self.maskView = [[UIButton alloc] initWithFrame:self.view.bounds];
        _maskView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        [_maskView addTarget:self action:@selector(dismissBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _popShadowView = [[UIView alloc] initWithFrame:CGRectZero];
        _popShadowView.layer.shadowOpacity = 0.5;
        _popShadowView.layer.shadowRadius = 4;
        _popShadowView.layer.cornerRadius = 4;
        _popShadowView.layer.shadowOffset = CGSizeMake(1, 3);
        _popShadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        [_maskView addSubview:_popShadowView];
    }
    
    CGRect frame = CGRectMake((_maskView.frame.size.width - size.width) / 2, (_maskView.frame.size.height - size.height) / 2, size.width, size.height);
    controller.view.frame = frame;
    _popShadowView.frame = frame;
    
    controller.view.layer.cornerRadius = 4;
    controller.view.layer.masksToBounds = TRUE;
    
    if (!reset) {
        _maskView.alpha = 0;
        controller.view.alpha = 0;
    }
    
    [self.navigationController.view addSubview:_maskView];
    
    self.popController = controller;
    [self.navigationController addChildViewController:controller];
    [_maskView addSubview:controller.view];
    
    _popShadowView.backgroundColor = [UIColor clearColor];
    
    [_popController viewWillAppear:YES];
    
    if (reset) {
        [UIView animateWithDuration:0.2 animations:^{
            controller.view.alpha = 1;
        } completion:^(BOOL finished) {
            _popShadowView.backgroundColor = [UIColor whiteColor];
        }];
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            _maskView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                controller.view.alpha = 1;
            } completion:^(BOOL finished) {
                _popShadowView.backgroundColor = [UIColor whiteColor];
            }];
        }];
    }
}

- (void)popoverChangeRect:(CGRect)rect withDuration:(NSTimeInterval)duration withCurve:(UIViewAnimationCurve)curve
{
    if (_popController) {
        [UIView beginAnimations:@"changeViewFrame" context:NULL];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationCurve:curve];
        
        _popController.view.frame = rect;
        _popShadowView.frame = rect;
        
        [UIView commitAnimations];
    }
}

- (void)popoverChangeSize:(CGSize)size
{
    if (_popController) {
        CGRect frame = CGRectMake((_maskView.frame.size.width - size.width) / 2, (_maskView.frame.size.height - size.height) / 2, size.width, size.height);
        [_popController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            _popController.view.frame = frame;
            _popShadowView.frame = frame;
        } completion:nil];
    }
}

- (void)dismissPopover
{
    [_popController viewWillDisappear:YES];
    _popShadowView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.1 animations:^{
        _popController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _maskView.alpha = 0;
        } completion:^(BOOL finished) {
            [_popController.view removeFromSuperview];
            [_popController removeFromParentViewController];
            [_maskView removeFromSuperview];
            self.popController = nil;
        }];
    }];
}

- (void)dismissBtnAction
{
    [_popController.view endEditing:YES];
    id controller = _popController;
    if ([controller isKindOfClass:[UINavigationController class]]) {
        controller = ((UINavigationController *)controller).topViewController;
    }
//    if ([controller isKindOfClass:[COAddTweetController class]]) {
//        [((COAddTweetController *)controller) hideKeyboard];
//    } else if ([controller isKindOfClass:[COTweetAddCommentController class]]) {
//        [((COTweetAddCommentController *)controller) hideKeyboard];
//    }
}

- (void)setupKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    
    CGRect rect =_popController.view.frame;
    self.rect=rect;
    rect=CGRectMake(rect.origin.x, rect.origin.y-45, rect.size.width, rect.size.height);
    _popController.view.frame=rect;
    _popShadowView.frame=rect;
    [self.view layoutSubviews];
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    _popController.view.frame=self.rect;
    _popShadowView.frame=self.rect;
//    _popController.center=CGPointMake(kScreen_Width*0.5, kScreen_Height*0.3);
    
    [self.view layoutSubviews];
}


@end
