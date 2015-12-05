//
//  IndexViewController.m
//  eduadmin
//
//  Created by Li Jie on 14/12/30.
//  Copyright (c) 2014年 PUPBOSS. All rights reserved.
//

#import "IndexViewController.h"
#import "MBProgressHUD+LJ.h"
#import "AFNetworking.h"
#import "LJTools.h"
#import "Common.h"

@interface IndexViewController () <UIActionSheetDelegate, UIAlertViewDelegate> {
    
    NSArray *_helloArr;
    NSInteger _clickTime;
}
@end

@implementation IndexViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.helloLable.numberOfLines = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.def = [NSUserDefaults standardUserDefaults];
    
    _helloArr = @[@"爱生活不爱黑眼圈,快洗洗睡吧",@"一日之计在于晨,上课可别打瞌睡哦",@"坐等下课吃饭去",@"吃个饱饭睡个美容觉,这真是极好的",@"中午养足了精神吗?让我们一起渡过一个愉快的下午茶时间,不过没有茶喝o(╯□╰)o",@"静能生慧.仰观宇宙之大,俯察品类之盛.宇宙之大,每个生命都在孤寂"];
    
    [self setHelloLableText];
    _clickTime = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![self.def objectForKey:LOGINTOKEN]) {
        
        [self performSegueWithIdentifier:@"index2login" sender:nil];

    } else {
        
        if ([[self.def objectForKey:HASSENTTOSERVER] isEqualToString:@"0"]) {
            
            [self sendTokenToServer];
        }
        [self getPhotoAndName];
    }
}


- (void)sendTokenToServer {

    NSDictionary *param = @{@"userId": [self.def objectForKey:USERNAMEKEY], @"deviceToken": [self.def objectForKey:PUSHTOKENNEW]};
    
    [LJHTTPTool postJSONWithURL:[NSString stringWithFormat:@"%@device-token/insert", TOKENURL] params:param success:^(id responseJSON) {
        
        [self.def setObject:@"1" forKey:HASSENTTOSERVER];
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)setHelloLableText {
    
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"凌晨"]) {
        self.helloLable.text = _helloArr[0];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"早上"]) {
        self.helloLable.text = _helloArr[1];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"上午"]) {
        self.helloLable.text = _helloArr[2];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"中午"]) {
        self.helloLable.text = _helloArr[3];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"下午"]) {
        self.helloLable.text = _helloArr[4];
    }
    if ([[LJTimeTool getCurrentInterval] isEqualToString:@"晚上"]) {
        self.helloLable.text = _helloArr[5];
    }
}

- (void)getPhotoAndName {
    
    NSString *filePath = [LJFileTool getFilePath:selfInfoFileName];

    NSFileManager *mgr = [NSFileManager defaultManager];

    if ([mgr fileExistsAtPath:filePath]) {
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        self.nameLable.text = [NSString stringWithFormat:@"%@好,%@",[LJTimeTool getCurrentInterval],dict[@"name"]];
        
    } else {
    
        [LJHTTPTool getJSONWithURL:[NSString stringWithFormat:@"%@student/~self", MAINURL] params:nil success:^(id responseJSON) {
            
            [LJFileTool writeToFileContent:responseJSON withFileName:selfInfoFileName];
            
            NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseJSON];
            [LJFileTool writeImageToFileName:selfIconFileName withImgURL:dict[@"photoUrl"]];
            self.nameLable.text = [NSString stringWithFormat:@"%@好,%@",[LJTimeTool getCurrentInterval],dict[@"name"]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}

- (IBAction)logout:(id)sender {
    
    #ifdef __IPHONE_8_0
        
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"教务处APP" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *escAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self performSegueWithIdentifier:@"index2login" sender:nil];
    }];
    
    [alertController addAction:escAction];
    
    UIAlertAction *donateAction = [UIAlertAction actionWithTitle:@"做一些捐赠" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self performSegueWithIdentifier:@"main2Donate" sender:nil];
    }];
    
    [alertController addAction:donateAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    
    [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
    alertController.popoverPresentationController.barButtonItem = self.escButton;
    alertController.popoverPresentationController.sourceView = self.view;
    
    [self presentViewController:alertController animated:YES completion:nil];
        
    #else
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"教务处APP" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles: nil];
    [sheet showInView:self.view];
    
    #endif
    
}

- (IBAction)myInfo {
    
    [self performSegueWithIdentifier:@"main2Info" sender:nil];
}

- (IBAction)mySchedule {
    
    [self performSegueWithIdentifier:@"main2Schedule" sender:nil];
}

- (IBAction)announce {
    
    [self performSegueWithIdentifier:@"main2Web" sender:nil];
}

- (IBAction)unpassGrade {
    
    [self performSegueWithIdentifier:@"main2Unpass" sender:nil];
}

- (IBAction)queryGrade {
    
    [self performSegueWithIdentifier:@"main2Grade" sender:nil];
}

- (IBAction)examPlan {
    
    [self performSegueWithIdentifier:@"main2Exam" sender:nil];
}

- (IBAction)skillTest {
    
    [self performSegueWithIdentifier:@"main2Skill" sender:nil];
}

- (IBAction)donate {
    
    if (_clickTime == 0) {
        
        [MBProgressHUD showError:@"都说了啥都没有...别点了"];
    }
    if (_clickTime == 2) {
        
        [MBProgressHUD showError:@"我擦，你还点，点也没用"];
    }
    if (_clickTime == 3) {
        
        [MBProgressHUD showError:@"为啥吧，因为压根就没做啊"];
    }
    if (_clickTime == 4) {
        
        [MBProgressHUD showError:@"去商店评波分吧(ง •̀灬•́)ง"];
    }
    _clickTime ++;
}

- (IBAction)oneKeyRate {
    
    [self performSegueWithIdentifier:@"main2Rate" sender:nil];
}

- (IBAction)fresher {
    
    [self performSegueWithIdentifier:@"main2Fresher" sender:nil];
}

#pragma mark ActionSheet代理方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    [self performSegueWithIdentifier:@"index2login" sender:nil];
}

@end
