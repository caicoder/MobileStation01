//
//  COLoginViewController.m
//  CodingForiPad
//
//  Created by sunguanglei on 15/6/20.
//  Copyright (c) 2015年 coding. All rights reserved.
//

#import "COLoginViewController.h"
//#import "COSession.h"
//#import "COAccountRequest.h"
//#import "COUtility.h"
//#import "UIImageView+WebCache.h"
#import "CORegServiceViewController.h"
//#import "CORegMailTipsView.h"
//#import "UIActionSheet+Common.h"

#define kCOCaptchaHeight 50.0

#define kCOLoginViewHeight CGRectGetHeight(self.view.frame)
#define kCOLoginPopHeight CGRectGetHeight(self.loginView.frame)
#define kCOLoginShowOffset     100//((kCOLoginViewHeight - kCOLoginPopHeight)/2)

@interface COLoginViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL needCaptcha;
@property (nonatomic, assign) BOOL regNeedCaptcha;
//@property (nonatomic, strong) CORegMailTipsView *mailView;

@end

@implementation COLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginView.layer.cornerRadius = 4.0;
    self.loginView.layer.masksToBounds = YES;
    self.registerView.layer.cornerRadius = 4.0;
    self.registerView.layer.masksToBounds = YES;
    self.registerView.hidden = YES;
    self.findView.layer.cornerRadius = 4.0;
    self.findView.layer.masksToBounds = YES;
    self.authView.layer.cornerRadius = 4.0;
    self.authView.layer.masksToBounds = YES;
    
    self.catpchaHeight.constant = 0.0;
    
//    self.mailView = [[CORegMailTipsView alloc] initForTextField:_mailField height:30.0];
    
    [self tapToHideKeyboard];
    [self setupKeyboardNotification];
    
//    [self requestCaptcha];
    self.regCatpchaView.hidden = YES;
    
    [self updateState:COLoginStateLogin];
    
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadLoginCaptach)];
        [self.codeImageView addGestureRecognizer:tap];
        self.codeImageView.userInteractionEnabled = YES;
    }
    
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadRegCaptach)];
        [self.regCodeImageView addGestureRecognizer:tap];
        self.regCodeImageView.userInteractionEnabled = YES;
    }
    
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadfindCaptach)];
        [self.findCodeImageView addGestureRecognizer:tap];
        self.findCodeImageView.userInteractionEnabled = YES;
    }
    
    self.loginViewOffset.constant =
    self.registerViewOffset.constant =
    self.authViewOffset.constant =
    self.findViewOffset.constant = kCOLoginShowOffset;
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)reloadLoginCaptach
{
//    [self showCaptcha];
}

- (void)reloadRegCaptach
{
//    [self showRegCaptcha];
}

- (void)reloadfindCaptach
{
    [self loadFindCatpcha];
}

- (void)tapToHideKeyboard
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self.view endEditing:YES];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view.superview isKindOfClass:[UITableViewCell class]]) {
        // we touched a button, slider, or other UIControl
        return NO; // ignore the touch
    }
    return YES; // handle the touch
}

#pragma mark - Update State
- (void)updateState:(COLoginState)state
{
    self.preState = self.state;
    self.state = state;
    
    _loginView.hidden = (self.state == COLoginStateLogin ? NO : YES);
    _registerView.hidden = (self.state == COLoginStateRegister ? NO : YES);
    _authView.hidden = (self.state == COLoginStateAuth ? NO : YES);
    _findView.hidden = ((self.state == COLoginStateFindPass || self.state == COLoginStateActive) ? NO : YES);
    
    if (self.state == COLoginStateFindPass) {
        [self.findSendBtn setTitle:@"发送重置密码邮件" forState:UIControlStateNormal];
    }
    else if (self.state == COLoginStateActive) {
        [self.findSendBtn setTitle:@"重发激活邮件" forState:UIControlStateNormal];
    }
    else {
        [self.findSendBtn setTitle:@"" forState:UIControlStateNormal];
    }
}



- (BOOL)checkField
{
    if (_nameField.text.length == 0) {
        [MBProgressHUD showWithText:@"用户名不能为空"];
        return NO;
    }
    
    if (_passwdField.text.length == 0) {
        [MBProgressHUD showWithText:@"密码不能为空"];
        return NO;
    }
    
    return YES;
}

- (IBAction)cantLoginAction:(id)sender
{
    [self.view endEditing:YES];

}

- (IBAction)loginAction:(id)sender
{
    if ([self checkField]) {
        NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
        [dic setValue:self.nameField.text forKey:@"account"];
        [dic setValue:self.passwdField.text forKey:@"password"];
        [dic setObject:@"login" forKey:@"type"];
        [[MBNetWorkTool sharedNetworkTools]makeGetRequestwithParameters:dic success:^(NSDictionary *results) {
            NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
            [MBProgressHUD showWithText:[results valueForKey:@"reason"]];
            NSString * userKey =[results valueForKey:@"userkey"];
            [stand setObject:userKey forKey:USERKEY];
            [[NSNotificationCenter defaultCenter] postNotificationName:__USER_LOGIN_SUCCESS object:nil];
            
        } fail:^(NSDictionary *results) {
             [MBProgressHUD showWithText:[results valueForKey:@"reason"]];
        } error:^(NSError *results) {
            
        }];
    }
}


-(void)dealloc
{
    [HMNoteCenter removeObserver:self];
}

- (void)hideRegCaptcha
{
    if (self.regCatpchaHeight.constant == 0.0) {
        return;
    }
    
    self.regCatpchaHeight.constant = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.regCatpchaView layoutIfNeeded];
    }];
}
- (IBAction)registerAction:(id)sender
{
    if ([self checkRegisterField]) {
        NSMutableDictionary * dic=[[NSMutableDictionary alloc]init];
        [dic setValue:self.mailField.text forKey:@"account"];
        [dic setValue:self.globalKeyField.text forKey:@"password"];
        [dic setObject:@"register" forKey:@"type"];
        [[MBNetWorkTool sharedNetworkTools]makeGetRequestwithParameters:dic success:^(NSDictionary *results) {
            
        } fail:^(NSDictionary *results) {
            [MBProgressHUD showWithText:[results valueForKey:@"reason"]];
        } error:^(NSError *results) {
            
        }];
    }
    
}

- (BOOL)checkRegisterField
{
    if (self.mailField.text.length == 0) {
        [MBProgressHUD showWithText:@"手机号不能为空"];
        return NO;
    }
    
    if (self.globalKeyField.text.length == 0) {
        [MBProgressHUD showWithText:@"密码不能为空"];
        return NO;
    }
    
    return YES;
}
- (IBAction)showServiceAction:(id)sender
{
    [self.view endEditing:YES];
    
    CGSize viewSize = self.view.bounds.size;
    CGSize serviceSize = CGSizeMake(viewSize.width * 0.5, viewSize.height * 0.7);
    
    CORegServiceViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CORegServiceViewController"];
    controller.view.frame = CGRectMake((viewSize.width - serviceSize.width) /2, viewSize.height, serviceSize.width, serviceSize.height);
    controller.view.layer.cornerRadius = 4.0;
    controller.view.layer.masksToBounds = YES;
    
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
    
    [UIView animateWithDuration:0.3 animations:^{
        controller.view.center = self.view.center;
    }];
}

#pragma mark - 二次认证
- (IBAction)authCodeAction:(id)sender
{
    if (_authCodeField.text.length == 0) {
        // TODO: 用户名不能为空
//        [self showErrorWithStatus:@"动态验证码不能为空"];
        return;
    }
    

}


#pragma mark - 状态转换
// 注册
- (IBAction)changeToRegist:(id)sender
{
    [self.view endEditing:YES];
    self.registerViewOffset.constant = kCOLoginViewHeight;
    [self.view layoutIfNeeded];
    
    self.registerView.hidden = NO;
    
    if (self.state == COLoginStateAuth) {
        self.authViewOffset.constant = -kCOLoginPopHeight;
    }
    else if (self.state == COLoginStateLogin) {
        self.loginViewOffset.constant = -kCOLoginPopHeight;
    }
    
    self.registerViewOffset.constant = kCOLoginShowOffset;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.loginView.hidden = YES;
        self.loginViewOffset.constant = kCOLoginShowOffset;
        self.authView.hidden = YES;
        self.authViewOffset.constant = kCOLoginShowOffset;
//        [self requestRegCaptcha];
        [self updateState:COLoginStateRegister];
    }];
}

// 登录
- (IBAction)changeToLogin:(id)sender
{

    
    [self.view endEditing:YES];
    self.loginViewOffset.constant = -kCOLoginPopHeight;
    [self.view layoutIfNeeded];
    self.loginView.hidden = NO;
    self.loginViewOffset.constant = kCOLoginShowOffset;
    self.registerViewOffset.constant = kCOLoginViewHeight;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.registerView.hidden = YES;
        self.registerViewOffset.constant = kCOLoginShowOffset;
//        [self requestCaptcha];
        [self updateState:COLoginStateLogin];
    }];
}

// 二次认证提示
- (void)showAuthCode
{
    [self.view endEditing:YES];
    self.authView.alpha = 0.0;
    self.authView.hidden = NO;
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.authView.alpha = 1.0;
        self.loginView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.loginView.hidden = YES;
        self.loginView.alpha = 1.0;
        [self updateState:COLoginStateAuth];
    }];
}

// 找回密码
- (void)findPassword
{
    
}

- (void)loadFindCatpcha
{
//    NSString *url = [NSString stringWithFormat:@"%@/getCaptcha", COAPIDomain];
//    __weak typeof(self) weakself = self;
//    [self.findCodeImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageHandleCookies | SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakself.regCodeImageView.image = [UIImage imageNamed:@"captcha_loadfail"];
//            });
//        }
//    }];
}

// 发送激活邮件
- (void)resendMail
{
    
}

// 关闭
- (IBAction)findCloseAction:(id)sender
{
    [self.view endEditing:YES];
    if (self.preState == COLoginStateLogin) {
        self.loginView.alpha = 0.0;
        self.loginView.hidden = NO;
    }
    else if (self.preState == COLoginStateAuth) {
        self.authView.alpha = 0.0;
        self.authView.hidden = NO;
    }
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.findView.alpha = 0.0;
        self.loginView.alpha = 1.0;
        self.authView.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.findView.hidden = YES;
        self.findView.alpha = 1.0;
        self.findCatpchaField.text = @"";
        self.findMailField.text = @"";
        [self updateState:self.preState];
    }];
}

#pragma mark -
- (void)setupKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameChanged:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidChangeFrameNotification
                                                  object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    /*
     NSString *const UIKeyboardFrameBeginUserInfoKey;
     NSString *const UIKeyboardFrameEndUserInfoKey;
     NSString *const UIKeyboardAnimationDurationUserInfoKey;
     NSString *const UIKeyboardAnimationCurveUserInfoKey;
     */
    
//    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardStartFrame = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    if (keyboardStartFrame.origin.y != [UIScreen mainScreen].bounds.size.height) {
        return;
    }
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    self.loginViewOffset.constant = 44.0;
    self.registerViewOffset.constant = 44.0;
    self.authViewOffset.constant = 44.0;
    self.findViewOffset.constant = 44.0;
    [UIView animateWithDuration:duration delay:0.0 options:curve animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    self.loginViewOffset.constant =
    self.registerViewOffset.constant =
    self.authViewOffset.constant =
    self.findViewOffset.constant = kCOLoginShowOffset;
    [UIView animateWithDuration:duration delay:0.0 options:curve animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    
}

- (void)keyboardDidHide:(NSNotification*)notification
{
    
}

- (void)keyboardFrameChanged:(NSNotification*)notification
{
    
}

@end
