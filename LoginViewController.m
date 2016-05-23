//
//  LoginViewController.m
//  WTF
//
//  Created by 黄春涛 on 16/5/23.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //手势收起键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated{
    //自动登陆
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        [self performSegueWithIdentifier:@"toTabVC" sender:nil];
    } else {
       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Target & Action
//点击了登陆按钮
- (IBAction)login:(id)sender {
    
    [self.view endEditing:YES];
    
    [AVUser logInWithUsernameInBackground:_userNameTextField.text password:_passwordTextField.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            //登陆成功
            [self performSegueWithIdentifier:@"toTabVC" sender:sender];
            
        } else {
            //登陆失败
            NSString *toastString = [error.userInfo objectForKey:@"error"];
            [self.view makeToast:toastString];
        }
    }];
    
}

- (void)viewTapped:(id)sender{
    [self.view endEditing:YES];
}



@end
