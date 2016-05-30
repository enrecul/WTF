//
//  MeViewController.m
//  WTF
//
//  Created by 黄春涛 on 16/5/17.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import "ProfileTableViewCell.h"
#import "LogoutTableViewCell.h"
#import "WTFUser.h"

#import <AssetsLibrary/AssetsLibrary.h>

#define kProfileTableViewCell_Height 80
#define kDefaultTableViewCell_Height 60

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ProfileTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ProfileTableViewCell class])];
        [_tableView registerClass:[LogoutTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LogoutTableViewCell class])];
        _tableView;
    })];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ProfileTableViewCell *profileCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ProfileTableViewCell class]) forIndexPath:indexPath];
            [profileCell setWTFUser:[WTFUser currentUser]];
            profileCell.editProfileBlock = ^{
                //点击了编辑头像按钮
                UIActionSheet *editProfileActionSheet = [[UIActionSheet alloc] initWithTitle:@"编辑个人资料"
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"更换头像",@"修改昵称", nil];
                [editProfileActionSheet showInView:self.view];
            };
            cell = profileCell;
        }
    }
    else if(indexPath.section == 1){
        if(indexPath.row == 0){
            LogoutTableViewCell *logoutCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogoutTableViewCell class]) forIndexPath:indexPath];
            logoutCell.logOut = ^{
                //退出登录
                [AVUser logOut];
                
                UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                
                UINavigationController* navVC  = [[UINavigationController alloc]initWithRootViewController:loginVC];
                [navVC setNavigationBarHidden:YES];
                UIWindow *window = [UIApplication sharedApplication].delegate.window;
                window.rootViewController = navVC;
                [window makeKeyAndVisible];
                
            };
            cell = logoutCell;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return kProfileTableViewCell_Height;
            break;
            
        default:
            return kDefaultTableViewCell_Height;
            break;
    }
}

#pragma mark - UITableViewDelegate


#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            //打开相册
            [self choosePhoto];
            break;
        case 1:
            //修改昵称
            [self changeName];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField *textField =[alertView textFieldAtIndex:0];
    [textField resignFirstResponder];
    NSString *newName = textField.text;

    switch (buttonIndex) {
        case 0:{
           break;
        }
        case 1:{
            //确定修改
            if (newName.length) {
                WTFUser *currentUser = [WTFUser currentUser];
                currentUser.nickName = newName;
                [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    //更新UI
                    [_tableView reloadData];
                }];
                
            }
            else{
                [self.view makeToast:@"新昵称不能为空" duration:1 position:CSToastPositionCenter style:nil];
            }
            break;
        }
        default:
            break;
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    //获取到新头像，上传服务端
    NSData *avatarData = [image imageDataRepresentation];
    AVFile *avatarFile = [AVFile fileWithData:avatarData];
    [avatarFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //获取到文件路径
            WTFUser *currentUser = [WTFUser currentUser];
            currentUser.avatarFile = avatarFile;
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                //更新UI
                [_tableView reloadData];
            }];
        }
        else{
            [self.view makeToast:@"更换头像失败，请重试"];
        }
    }];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private Function

- (void)choosePhoto{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        [self.view makeToast:@"请您设置允许APP访问您的相册\n设置>隐私>照片"];
        return ;
    } else {
        //打开相册
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate = self;
        pick.allowsEditing = YES;
        [self presentViewController:pick animated:YES completion:nil];
    }

}

- (void)changeName{
    UIAlertView *changNameAlertView = [[UIAlertView alloc] initWithTitle:@"修改昵称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    changNameAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [changNameAlertView textFieldAtIndex:0].text = CURRENT_USERNAME;
    [changNameAlertView show];
}


@end
