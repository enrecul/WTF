//
//  RegisterViewController.m
//  WTF
//
//  Created by 黄春涛 on 16/5/23.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "RegisterViewController.h"
#import "WTFUser.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
}


#pragma mark - Target & Action
//点击直接登陆按钮
- (IBAction)backToLoginVC:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
//完成注册按钮点击
- (IBAction)finishRegister:(id)sender {
    
    [self.view endEditing:YES];

    
    NSString *username = _userNameTextField.text;
    NSString *email = _emailTextField.text;
    NSString *password = _passwordTextField.text;
    
    WTFUser *user = [WTFUser user];
    user.nickName = username;
    user.username = email;
    user.email = email;
    user.password = password;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //注册成功
            [self.view makeToast:@"注册成功"];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else{
            //注册失败
            NSString *toastString = [error.userInfo objectForKey:@"error"];
            [self.view makeToast:toastString];
        }
    }];
    
}

- (void)viewTapped:(id)sender{
    [self.view endEditing:YES];
}

@end
